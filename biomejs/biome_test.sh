#!/bin/bash

source .include/test.sh

test "$(dirname "$0")/biome.sh" "1.5.0"
