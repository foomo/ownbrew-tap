#!/bin/bash

source .include/test.sh

test "$(dirname $0)/xk6-dashboard.sh" "0.4.4"
