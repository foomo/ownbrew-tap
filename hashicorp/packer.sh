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

info "downloading ..."
curl -fL "https://releases.hashicorp.com/packer/${version}/packer_${version}_${os}_${arch}.zip" -o "${TEMP_DIR}/packer.zip"

info "extracting ..."
unzip "${TEMP_DIR}/packer.zip" -d "${TEMP_DIR}/packer"
mv "${TEMP_DIR}/packer/packer" "${BIN_DIR}/packer-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/packer-${version}-${os}-${arch}"

info "cleanup ..."
rm -rf "${TEMP_DIR}/packer" "${TEMP_DIR}/packer.zip"
