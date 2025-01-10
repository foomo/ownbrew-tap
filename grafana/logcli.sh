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
curl -fL "https://github.com/grafana/loki/releases/download/v${version}/logcli-${os}-${arch}.zip" -o "${TEMP_DIR}/logcli.zip"
curl -fL "https://github.com/grafana/loki/releases/download/v${version}/SHA256SUMS" -o "${TEMP_DIR}/logcli.zip.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/logcli.zip.sha256" | grep "logcli-${os}-${arch}.zip" | awk '{print $1;}')  ${TEMP_DIR}/logcli.zip" | shasum -a 256 --check --quiet

info "extracting ..."
unzip -p "${TEMP_DIR}/logcli.zip" "logcli-${os}-${arch}" > "${BIN_DIR}/logcli-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/logcli-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/logcli.zip" "${TEMP_DIR}/logcli.zip.sha256"
