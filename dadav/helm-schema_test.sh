#!/bin/bash

source .include/test.sh

test "$(dirname $0)/helm-schema.sh" "0.14.1"
