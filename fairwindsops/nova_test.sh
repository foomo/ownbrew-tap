#!/bin/bash

source .include/test.sh

test "$(dirname $0)/nova.sh" "3.10.1"
