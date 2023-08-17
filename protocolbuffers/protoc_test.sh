#!/bin/bash

source .include/test.sh

test "$(dirname $0)/protoc.sh" "3.19.1"
