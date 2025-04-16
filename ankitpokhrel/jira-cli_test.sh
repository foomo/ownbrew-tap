#!/bin/bash

source .include/test.sh

test "$(dirname "$0")/jira-cli.sh" "1.5.2"
