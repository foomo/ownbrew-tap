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
curl -fL "https://github.com/stern/stern/releases/download/v${version}/stern_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/stern.tar.gz"
curl -fL "https://github.com/stern/stern/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/stern.tar.gz.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/stern.tar.gz.sha256" | grep "stern_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/stern.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/stern.tar.gz" -C "${TEMP_DIR}" stern
mv -f "${TEMP_DIR}/stern" "${BIN_DIR}/stern-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/stern-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/stern.tar.gz" "${TEMP_DIR}/stern.tar.gz.sha256"
