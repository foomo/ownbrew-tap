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
linux) os_alias="linux";;
darwin) os_alias="osx";;
esac

info "downloading ..."
curl -fL "https://github.com/rclone/rclone/releases/download/v${version}/rclone-v${version}-${os_alias}-${arch}.zip" -o "${TEMP_DIR}/rclone.zip"
curl -fL "https://github.com/rclone/rclone/releases/download/v${version}/SHA256SUMS" -o "${TEMP_DIR}/rclone.zip.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/rclone.zip.sha256" | grep "rclone-v${version}-${os_alias}-${arch}.zip" | awk '{print $1;}')  ${TEMP_DIR}/rclone.zip" | shasum -a 256 --check --quiet

info "extracting ..."
unzip "${TEMP_DIR}/rclone.zip" -d "${TEMP_DIR}"
mv "${TEMP_DIR}/rclone-v${version}-${os_alias}-${arch}/rclone" "${BIN_DIR}/rclone-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/rclone-${version}-${os}-${arch}"

info "cleanup ..."
rm -rf "${TEMP_DIR}/rclone-v${version}-${os_alias}-${arch}" "${TEMP_DIR}/rclone.zip" "${TEMP_DIR}/rclone.zip.sha256"
