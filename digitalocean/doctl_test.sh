#!/bin/bash

source .include/test.sh

test "$(dirname $0)/doctl.sh" "1.100.0"
