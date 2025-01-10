#!/bin/bash

source .include/test.sh

test "$(dirname $0)/bun.sh" "1.1.43"
