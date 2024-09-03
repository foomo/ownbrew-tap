#!/bin/bash

source .include/test.sh

test "$(dirname $0)/polaris.sh" "9.2.1"
