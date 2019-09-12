package main

import (
	"github.com/yalp/jsonpath"
	"encoding/json"
	"os"
	"io/ioutil"
	"fmt"
)

func main() {
	selector := os.Args[1]

	data, err := ioutil.ReadAll(os.Stdin)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	var json_data interface{}
	json.Unmarshal([]byte(data), &json_data)

	result, err := jsonpath.Read(json_data, selector)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	json_result, err := json.Marshal(result)
	fmt.Println(string(json_result))
}
