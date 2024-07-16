#!/bin/bash

source .include/test.sh

test "$(dirname $0)/terraform.sh" "1.9.2"
