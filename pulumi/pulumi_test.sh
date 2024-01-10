#!/bin/bash

source .include/test.sh

test "$(dirname "$0")/pulumi.sh" "3.101.0"
