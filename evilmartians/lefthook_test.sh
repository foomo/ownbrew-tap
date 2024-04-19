#!/bin/bash

source .include/test.sh

test "$(dirname $0)/lefthook.sh" "1.6.10"
