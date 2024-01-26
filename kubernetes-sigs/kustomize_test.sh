#!/bin/bash

source .include/test.sh

test "$(dirname $0)/kustomize.sh" "5.3.0"
