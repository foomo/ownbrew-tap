#!/bin/bash

source .include/test.sh

test "$(dirname $0)/robusta.sh" "0.17.0"
