#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/k9s.sh" "0.27.4"
