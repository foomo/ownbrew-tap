#!/bin/bash

source .include/test.sh

test "$(dirname $0)/oapi-codegen.sh" "2.3.0"
