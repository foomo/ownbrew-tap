#!/bin/bash

source .include/test.sh

test "$(dirname $0)/kubectl-slice.sh" "1.4.2"
