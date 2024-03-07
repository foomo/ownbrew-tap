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
curl -fL "https://github.com/foomo/sesamy-cli/releases/download/v${version}/sesamy-cli_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/sesamy-cli.tar.gz"
curl -fL "https://github.com/foomo/sesamy-cli/releases/download/v${version}/sesamy-cli_${version}_checksums.txt" -o "${TEMP_DIR}/sesamy-cli.tar.gz.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/sesamy-cli.tar.gz.sha256" | grep "sesamy-cli_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/sesamy-cli.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/sesamy-cli.tar.gz" -C "${TEMP_DIR}" sesamy
mv -f "${TEMP_DIR}/sesamy" "${BIN_DIR}/sesamy-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/sesamy-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/sesamy-cli.tar.gz" "${TEMP_DIR}/sesamy-cli.tar.gz.sha256"
