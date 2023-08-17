#!/bin/bash

source .include/test.sh

test "$(dirname $0)/squadron.sh" "1.9.0"
