#!/bin/bash

source .include/test.sh

test "$(dirname $0)/yq.sh" "4.47.1"
