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
curl -fL "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${version}/kustomize_v${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/kustomize.tar.gz"
curl -fL "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${version}/checksums.txt" -o "${TEMP_DIR}/kustomize.sha256"

info "validating ...."
echo "$(cat "${TEMP_DIR}/kustomize.sha256" | grep "kustomize_v${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/kustomize.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/kustomize.tar.gz" -C "${TEMP_DIR}" kustomize
mv -f "${TEMP_DIR}/kustomize" "${BIN_DIR}/kustomize-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/kustomize-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/kustomize.tar.gz"
