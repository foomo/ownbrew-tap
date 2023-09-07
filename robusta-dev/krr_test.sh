#!/bin/bash

source .include/test.sh

test "$(dirname $0)/krr.sh" "1.6.0"
