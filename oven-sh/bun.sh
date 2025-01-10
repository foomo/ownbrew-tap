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

case $arch in
amd64) arch_alias="x64";;
arm64) arch_alias="aarch64";;
esac

info "downloading ..."
curl -fL "https://github.com/oven-sh/bun/releases/download/bun-v${version}/bun-${os}-${arch_alias}.zip" -o "${TEMP_DIR}/bun.zip"
curl -fL "https://github.com/oven-sh/bun/releases/download/bun-v${version}/SHASUMS256.txt" -o "${TEMP_DIR}/bun.zip.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/bun.zip.sha256" | grep "bun-${os}-${arch_alias}.zip" | awk '{print $1;}')  ${TEMP_DIR}/bun.zip" | shasum -a 256 --check --quiet

info "extracting ..."
unzip -p "${TEMP_DIR}/bun.zip" "bun-${os}-${arch_alias}/bun" > "${BIN_DIR}/bun-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/bun-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/bun.zip.sha256"
