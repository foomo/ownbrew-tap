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
curl -fL "https://github.com/sqlc-dev/sqlc/releases/download/v${version}/sqlc_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/sqlc.tar.gz"

info "extracting ..."
tar -xzvf "${TEMP_DIR}/sqlc.tar.gz" -C "${TEMP_DIR}" sqlc
mv -f "${TEMP_DIR}/sqlc" "${BIN_DIR}/sqlc-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/sqlc-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/sqlc.tar.gz"
