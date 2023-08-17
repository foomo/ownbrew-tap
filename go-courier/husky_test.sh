#!/bin/bash

source .include/test.sh

test "$(dirname $0)/husky.sh" "1.8.1"
