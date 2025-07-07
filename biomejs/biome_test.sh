#!/bin/bash

source .include/test.sh

test "$(dirname "$0")/biome.sh" "1.5.0"
test "$(dirname "$0")/biome.sh" "2.0.6"
