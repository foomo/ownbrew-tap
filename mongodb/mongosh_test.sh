#!/bin/bash

source .include/test.sh

test "$(dirname $0)/mongosh.sh" "1.10.3"
