#!/bin/bash

source .include/test.sh

test "$(dirname $0)/cloud-sql-proxy.sh" "2.15.2"
