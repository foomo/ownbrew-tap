#!/bin/bash

source .include/test.sh

test "$(dirname $0)/golangci-lint.sh" "2.12.2"
