#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/tflint.sh" "0.47.0"
