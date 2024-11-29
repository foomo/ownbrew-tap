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

case $arch in
amd64) arch_alias="x86_64";;
arm64) arch_alias="arm64";;
esac

info "downloading ..."
curl -fL "https://github.com/pressly/goose/releases/download/v${version}/goose_${os}_${arch_alias}" -o "${TEMP_DIR}/goose"
curl -fL "https://github.com/pressly/goose/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/goose.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/goose.sha256" | grep "goose_${os}_${arch_alias}" | awk '{print $1;}')  ${TEMP_DIR}/goose" | shasum -a 256 --check --quiet

info "extracting ..."
mv -f "${TEMP_DIR}/goose" "${BIN_DIR}/goose-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/goose-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/goose.sha256"
