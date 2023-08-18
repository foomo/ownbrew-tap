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
curl -fL "https://get.helm.sh/helm-v${version}-${os}-${arch}.tar.gz" -o "${TEMP_DIR}/helm.tar.gz"
curl -fL "https://get.helm.sh/helm-v${version}-${os}-${arch}.tar.gz.sha256sum" -o "${TEMP_DIR}/helm.tar.gz.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/helm.tar.gz.sha256" | grep "helm-v${version}-${os}-${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/helm.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/helm.tar.gz" -C "${TEMP_DIR}" --strip-components=1 "${os}-${arch}/helm"
mv -f "${TEMP_DIR}/helm" "${BIN_DIR}/helm-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/helm-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/helm.tar.gz" "${TEMP_DIR}/helm.tar.gz.sha256"
