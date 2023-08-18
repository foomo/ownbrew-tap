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

info "downloading ...."
curl -fL "https://dl.k8s.io/release/v${version}/bin/${os}/${arch}/kubectl" -o "${TEMP_DIR}/kubectl"
curl -fL "https://dl.k8s.io/v${version}/bin/${os}/${arch}/kubectl.sha256" -o "${TEMP_DIR}/kubectl.sha256"

info "validating ...."
echo "$(cat "${TEMP_DIR}/kubectl.sha256")  ${TEMP_DIR}/kubectl" | shasum -a 256 --check --quiet

info "extracting ...."
mv -f "${TEMP_DIR}/kubectl" "${BIN_DIR}/kubectl-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/kubectl-${version}-${os}-${arch}"

info "cleanup ...."
rm -f "${TEMP_DIR}/kubectl.sha256"