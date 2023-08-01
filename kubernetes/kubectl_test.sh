#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/kubectl.sh" "1.27.4"
