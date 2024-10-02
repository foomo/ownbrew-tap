#!/bin/bash

source .include/test.sh

test "$(dirname $0)/contentful-cli.sh" "3.3.15"
