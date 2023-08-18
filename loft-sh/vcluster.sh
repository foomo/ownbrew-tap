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
curl -fL "https://github.com/loft-sh/vcluster/releases/download/v${version}/vcluster-${os}-${arch}" -o "${TEMP_DIR}/vcluster"
curl -fL "https://github.com/loft-sh/vcluster/releases/download/v${version}/vcluster-${os}-${arch}.sha256" -o "${TEMP_DIR}/vcluster.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/vcluster.sha256")  ${TEMP_DIR}/vcluster" | shasum -a 256 --check --strict --quiet

info "extracting ..."
mv -f "${TEMP_DIR}/vcluster" "${BIN_DIR}/vcluster-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/vcluster-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/vcluster.sha256"
