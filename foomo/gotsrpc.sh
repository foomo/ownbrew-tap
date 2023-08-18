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
curl -sfL "https://github.com/foomo/gotsrpc/releases/download/v${version}/gotsrpc_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/gotsrpc.tar.gz"
curl -sfL "https://github.com/foomo/gotsrpc/releases/download/v${version}/gotsrpc_${version}_checksums.txt" -o "${TEMP_DIR}/gotsrpc.tar.gz.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/gotsrpc.tar.gz.sha256" | grep "gotsrpc_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/gotsrpc.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/gotsrpc.tar.gz" -C "${TEMP_DIR}" gotsrpc
mv -f "${TEMP_DIR}/gotsrpc" "${BIN_DIR}/gotsrpc-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/gotsrpc-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/gotsrpc.tar.gz" "${TEMP_DIR}/gotsrpc.tar.gz.sha256"
