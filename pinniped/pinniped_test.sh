#!/bin/bash

source .include/test.sh

test "$(dirname $0)/pinniped.sh" "0.32.0"
