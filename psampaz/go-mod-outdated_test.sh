#!/bin/bash

source .include/test.sh

test "$(dirname $0)/go-mod-outdated.sh" "0.9.0"
