#!/bin/bash

source .include/test.sh

test "$(dirname $0)/logfrog.sh" "0.2.5"
