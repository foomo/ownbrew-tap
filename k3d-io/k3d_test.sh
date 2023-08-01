#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/k3d.sh" "5.5.1"
