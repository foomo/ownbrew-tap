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
darwin) os_alias="MacOS";;
esac

case $arch in
amd64) arch_alias="x86_64";;
arm64) arch_alias="arm64";;
esac

info "downloading ..."
curl -fL "https://github.com/evilmartians/lefthook/releases/download/v${version}/lefthook_${version}_${os_alias}_${arch_alias}" -o "${TEMP_DIR}/lefthook"
curl -fL "https://github.com/evilmartians/lefthook/releases/download/v${version}/lefthook_checksums.txt" -o "${TEMP_DIR}/lefthook.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/lefthook.sha256" | grep "lefthook_${version}_${os_alias}_${arch_alias}$" | awk '{print $1;}')  ${TEMP_DIR}/lefthook" | shasum -a 256 --check --quiet

info "extracting ..."
mv -f "${TEMP_DIR}/lefthook" "${BIN_DIR}/lefthook-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/lefthook-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/lefthook.sha256"
