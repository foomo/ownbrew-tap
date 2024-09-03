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
curl -fL "https://github.com/FairwindsOps/pluto/releases/download/v${version}/pluto_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/pluto.tar.gz"
curl -fL "https://github.com/FairwindsOps/pluto/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/pluto.tar.gz.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/pluto.tar.gz.sha256" | grep "pluto_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/pluto.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/pluto.tar.gz" -C "${TEMP_DIR}" pluto
mv -f "${TEMP_DIR}/pluto" "${BIN_DIR}/pluto-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/pluto-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/pluto.tar.gz" "${TEMP_DIR}/pluto.tar.gz.sha256"
