#!/usr/bin/env bash

source .include/test.sh

test "$(dirname "$0")/gotestfmt.sh" "2.5.0"
