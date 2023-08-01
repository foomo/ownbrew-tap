#!/usr/bin/env bash

set -e

source .include/colors.sh

os=${OS:=$(uname -s | tr '[:upper:]' '[:lower:]')}
arch=${ARCH:=$(arch)}

export BIN_DIR=${BIN_DIR:='./tmp/bin'}
export TEMP_DIR=${TEMP_DIR:='./tmp/tmp'}

function test() {
  local script=$1
  local version=$2
  echo -e "${CY}TEST: $script $os $arch $version${NC}" && $script $os $arch $version && echo -e "${CG}SUCCESS${NC}" || echo -e "${CR}FAILURE${NC}"
}