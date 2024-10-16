#!/bin/bash

source .include/test.sh

test "$(dirname $0)/helm-docs.sh" "1.14.2"
