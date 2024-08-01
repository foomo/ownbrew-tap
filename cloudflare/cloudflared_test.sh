#!/bin/bash

source .include/test.sh

test "$(dirname $0)/cloudflared.sh" "2024.6.1"
