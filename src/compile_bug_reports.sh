#!/bin/bash
set -euo pipefail

readonly results_dir="$1"
readonly consensus_dir="$2"
readonly implementation_dir="$3"

. src/shared.sh

all_queries() {
    find ./queries -type d -maxdepth 1 -mindepth 1 -print0 | xargs -0 -n1 basename | sort
}

indent_2() {
    sed 's/^/  /'
}

code_block() {
    echo "\`\`\`"
    cat
    echo "\`\`\`"
}

is_failing_while_gold_standard_exists() {
    local query="$1"
    local implementation="$2"

    local matching_implementations="${consensus_dir}/${query}"

    # matching implementations exist AND ours isn't in it
    [[ -s "$matching_implementations" ]] && ! grep "^${implementation}\$" < "$matching_implementations" > /dev/null
}

header() {
    echo "Results do not match other implementations

The following queries provide results that do not match those of other implementations of JSONPath
(compare https://cburgmer.github.io/json-path-comparison/):
"
}

footer() {
    local implementation="$1"

    echo
    echo "For reference, the output was generated by the program in https://github.com/cburgmer/json-path-comparison/tree/master/implementations/${implementation}."
}

gold_standard() {
    local query="$1"
    local matching_implementations="${consensus_dir}/${query}"
    local first_matching_implementation
    first_matching_implementation="$(head -1 < "$matching_implementations")"

    query_result_payload "${results_dir}/${query}/${first_matching_implementation}"
}

unwrap_scalar_if_needed() {
    local query="$1"

    if [[ -f "./implementations/${implementation}/SINGLE_POSSIBLE_MATCH_RETURNED_AS_SCALAR" && -f "./queries/${query}/SCALAR_RESULT" ]]; then
        ./src/unwrap_scalar.py
    else
        cat
    fi
}

# https://github.com/cburgmer/json-path-comparison/issues/1
needs_workaround_for_unknown_scalar_consensus() {
    local query="$1"
    local consensus="$2"
    test -f "./implementations/${implementation}/SINGLE_POSSIBLE_MATCH_RETURNED_AS_SCALAR" \
        && test -f "./queries/${query}/SCALAR_RESULT" \
        && test "$consensus" == "[]"
}

failing_query() {
    local query="$1"
    local selector
    local consensus

    selector="$(cat "./queries/${query}/selector")"
    consensus="$(gold_standard "$query")"

    if needs_workaround_for_unknown_scalar_consensus "$query" "$consensus"; then
        return
    fi

    echo "- [ ] \`${selector}\`"
    {
        echo "Input:"
        ./src/oneliner_json.py < "./queries/${query}/document.json" | code_block
        echo "Expected output:"
        unwrap_scalar_if_needed "$query" <<< "$consensus" | ./src/oneliner_json.py | code_block

        if is_query_result_ok "${results_dir}/${query}/${implementation}"; then
            echo "Actual output:"
            query_result_payload "${results_dir}/${query}/${implementation}" | unwrap_scalar_if_needed "$query" | ./src/oneliner_json.py | code_block
        else
            echo "Error:"
            query_result_payload "${results_dir}/${query}/${implementation}" | code_block
        fi
    } | indent_2

    echo
}

process_implementation() {
    local implementation="$1"
    local query

    header

    while IFS= read -r query; do
        if is_failing_while_gold_standard_exists "$query" "$implementation"; then
            failing_query "$query"
        fi
    done <<< "$(all_queries)"

    footer "$implementation"
}

main() {
    process_implementation "$(basename "$implementation_dir")"
}

main
