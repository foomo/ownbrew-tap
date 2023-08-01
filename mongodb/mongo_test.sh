#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/mongo.sh" "5.0.5"
