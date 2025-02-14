#!/bin/bash

source .include/test.sh

test "$(dirname $0)/cloudsqlproxy.sh" "2.15.0"
