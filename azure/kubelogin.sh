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

case $os in
linux) os_alias="Linux";;
darwin) os_alias="Darwin";;
esac

info "downloading ..."
curl -fL "https://github.com/Azure/kubelogin/releases/download/v${version}/kubelogin-${os}-${arch}.zip" -o "${TEMP_DIR}/kubelogin.zip"
curl -fL "https://github.com/Azure/kubelogin/releases/download/v${version}/kubelogin-${os}-${arch}.zip.sha256" -o "${TEMP_DIR}/kubelogin.zip.sha256"

info "validating ..."
echo "$(cat ${TEMP_DIR}/kubelogin.zip.sha256 | grep "kubelogin-${os}-${arch}.zip$" | awk '{print $1;}')  ${TEMP_DIR}/kubelogin.zip" | shasum -a 256 --check --quiet

info "extracting ..."
unzip -p "${TEMP_DIR}/kubelogin.zip" > "${BIN_DIR}/kubelogin-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/kubelogin-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/kubelogin.zip" "${TEMP_DIR}/kubelogin.zip.sha256"
