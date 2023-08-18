#!/bin/bash

source .include/test.sh

test "$(dirname $0)/teleport.sh" "13.1.0"
