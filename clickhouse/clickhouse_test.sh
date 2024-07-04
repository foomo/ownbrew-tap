#!/bin/bash

source .include/test.sh

test "$(dirname $0)/clickhouse.sh" "v24.5.1.1763-stable"
