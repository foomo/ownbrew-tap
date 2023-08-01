#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/terraform.sh" "1.4.6"
