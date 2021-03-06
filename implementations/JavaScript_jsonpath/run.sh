#!/bin/bash
set -euo pipefail

readonly script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$script_dir"

if [[ ! -d "node_modules" ]]; then
    npm install
fi

./index.js "$@"
