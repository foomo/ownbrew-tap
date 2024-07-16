#!/bin/bash

source .include/test.sh

test "$(dirname $0)/stackit-cli.sh" "0.9.0"
