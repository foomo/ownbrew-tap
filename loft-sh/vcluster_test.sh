#!/bin/bash

source .include/test.sh

test "$(dirname $0)/vcluster.sh" "0.15.2"
