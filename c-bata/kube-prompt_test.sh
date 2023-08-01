#!/usr/bin/env bash

source .include/test.sh

test "$(dirname $0)/kube-prompt.sh" "1.0.11"
