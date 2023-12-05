#!/bin/bash

source .include/test.sh

test "$(dirname $0)/mkcert.sh" "1.4.4"
