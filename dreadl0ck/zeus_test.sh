#!/bin/bash

source .include/test.sh

test "$(dirname $0)/zeus.sh" "0.9.14"
