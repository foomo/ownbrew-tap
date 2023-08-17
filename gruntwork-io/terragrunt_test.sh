#!/bin/bash

source .include/test.sh

test "$(dirname $0)/terragrunt.sh" "0.46.3"
