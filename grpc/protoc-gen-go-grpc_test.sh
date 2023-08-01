#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/protoc-gen-go-grpc.sh" "1.3.0"
