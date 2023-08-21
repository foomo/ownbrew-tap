#!/bin/bash

source .include/test.sh

test "$(dirname "$0")/gotestsum.sh" "1.10.1"
