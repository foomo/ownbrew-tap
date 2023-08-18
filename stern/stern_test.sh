#!/bin/bash

source .include/test.sh

test "$(dirname $0)/stern.sh" "1.25.0"
