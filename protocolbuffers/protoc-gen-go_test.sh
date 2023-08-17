#!/bin/bash

source .include/test.sh

test "$(dirname $0)/protoc-gen-go.sh" "1.27.1"
