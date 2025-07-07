#!/bin/bash

set -e

# colors
CRed='\033[1;31m'
CGray='\033[0;37m'
CGreen='\033[1;32m'
CYellow='\033[1;33m'
NC='\033[0m'

# logging
info() {
  echo -e "${CGray}${1}${NC}"
}

warn() {
  echo -e "${CYellow}${1}${NC}"
}

error() {
  echo -e "${CRed}${1}${NC}"
}

success() {
  echo -e "${CGreen}${1}${NC}"
}

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $arch in
amd64) arch_alias="x64";;
arm64) arch_alias="arm64";;
esac

info "downloading ..."
if [[ $version = 2* ]]; then
  curl -fL "https://github.com/biomejs/biome/releases/download/%40biomejs%2Fbiome%40${version}/biome-${os}-${arch_alias}" -o "${BIN_DIR}/biome-${version}-${os}-${arch}"
else
  curl -fL "https://github.com/biomejs/biome/releases/download/cli%2Fv${version}/biome-${os}-${arch_alias}" -o "${BIN_DIR}/biome-${version}-${os}-${arch}"
fi

info "extracting ..."
chmod a+x "${BIN_DIR}/biome-${version}-${os}-${arch}"
