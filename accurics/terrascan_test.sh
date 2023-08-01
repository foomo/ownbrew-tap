#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/terrascan.sh" "1.18.2"
