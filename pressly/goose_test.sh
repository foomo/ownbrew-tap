#!/bin/bash

source .include/test.sh

test "$(dirname $0)/goose.sh" "3.23.0"
