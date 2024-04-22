#!/bin/bash

source .include/test.sh

test "$(dirname $0)/yamlfmt.sh" "0.11.0"
