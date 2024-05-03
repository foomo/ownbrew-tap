#!/bin/bash

source ../.include/test.sh

test "$(dirname $0)/clickhouse.sh" "v24.4.1.2088-stable"
