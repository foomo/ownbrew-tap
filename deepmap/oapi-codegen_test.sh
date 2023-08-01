#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/oapi-codegen.sh" "1.13.0"
