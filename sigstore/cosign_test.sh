#!/bin/bash

source .include/test.sh

test "$(dirname $0)/cosign.sh" "2.4.0"
