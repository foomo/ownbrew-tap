#!/bin/bash

source .include/test.sh

test "$(dirname $0)/pluto.sh" "5.20.2"
