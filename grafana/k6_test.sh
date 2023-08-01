#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/k6.sh" "0.44.1"
