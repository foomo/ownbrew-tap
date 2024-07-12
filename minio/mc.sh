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
curl -fL "https://dl.min.io/client/mc/release/${os}-${arch}/archive/mc.RELEASE.${version}" -o "${TEMP_DIR}/mc"
curl -fL "https://dl.min.io/client/mc/release/${os}-${arch}/archive/mc.RELEASE.${version}.sha256sum" -o "${TEMP_DIR}/mc.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/mc.sha256" | grep "mc.RELEASE.${version}" | awk '{print $1;}')  ${TEMP_DIR}/mc" | shasum -a 256 --check --quiet

info "extracting ..."
mv -f "${TEMP_DIR}/mc" "${BIN_DIR}/mc-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mc-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/mc.sha256"
