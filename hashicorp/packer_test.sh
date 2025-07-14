#!/bin/bash

source .include/test.sh

test "$(dirname $0)/packer.sh" "1.13.1"
