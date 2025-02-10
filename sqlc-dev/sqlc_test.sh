#!/bin/bash

source .include/test.sh

test "$(dirname $0)/sqlc.sh" "1.28.0"
