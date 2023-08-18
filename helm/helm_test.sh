#!/bin/bash

source .include/test.sh

test "$(dirname $0)/helm.sh" "3.12.2"
