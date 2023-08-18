#!/bin/bash

source .include/test.sh

test "$(dirname $0)/kubectl-hns.sh" "1.1.0"
