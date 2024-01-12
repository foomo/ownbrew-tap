#!/bin/bash

source .include/test.sh

test "$(dirname $0)/kubelogin.sh" "0.1.0"
