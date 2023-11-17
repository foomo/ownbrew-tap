#!/bin/bash

source .include/test.sh

test "$(dirname $0)/k9s.sh" "0.28.2"
