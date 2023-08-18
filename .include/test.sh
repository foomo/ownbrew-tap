#!/bin/bash

set -e

CRed='\033[1;31m'
CGray='\033[0;37m'
CGreen='\033[1;32m'
CYellow='\033[1;33m'
NC='\033[0m'

os=${OS:=$(uname -s | tr '[:upper:]' '[:lower:]')}
arch=${ARCH:=$(arch)}

export BIN_DIR=${BIN_DIR:='./tmp/bin'}
export TEMP_DIR=${TEMP_DIR:='./tmp/tmp'}

function test() {
  local script=$1
  local version=$2
  echo -e "${CYellow}TEST: $script $os $arch $version${NC}" && $script $os $arch $version && echo -e "${CGreen}TEST: OK${NC}" || echo -e "${CRed}TEST: FAIL${NC}"
}