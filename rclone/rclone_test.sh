#!/bin/bash

source .include/test.sh

test "$(dirname $0)/rclone.sh" "1.67.0"
