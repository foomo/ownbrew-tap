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

case $os in
linux) os_alias="linux";;
darwin) os_alias="macos";;
esac

# TODO remove once supported
if [ "$arch" = "arm64" ]
then
	warn "WARN: using amd64 version"
fi

info "downloading ..."
curl -fL "https://github.com/jondot/hygen/releases/download/v${version}/hygen.${os_alias}.v${version}.tar.gz" -o "${TEMP_DIR}/hygen.tar.gz"

info "extracting ..."
tar -xzvf "${TEMP_DIR}/hygen.tar.gz" -C "${TEMP_DIR}" hygen
mv -f "${TEMP_DIR}/hygen" "${BIN_DIR}/hygen-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/hygen-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/hygen.tar.gz"
