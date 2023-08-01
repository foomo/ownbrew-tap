#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/golangci-lint.sh" "1.53.3"
