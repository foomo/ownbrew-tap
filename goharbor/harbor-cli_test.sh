#!/bin/bash

source .include/test.sh

test "$(dirname "$0")/harbor-cli.sh" "0.0.1"
