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
curl -fL "https://github.com/terraform-linters/tflint/releases/download/v${version}/tflint_${os}_${arch}.zip" -o "${TEMP_DIR}/tflint.zip"
curl -fL "https://github.com/terraform-linters/tflint/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/tflint.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/tflint.sha256" | grep "tflint_${os}_${arch}.zip" | awk '{print $1;}')  ${TEMP_DIR}/tflint.zip" | shasum -a 256 --check --quiet

info "extracting ..."
unzip -p "${TEMP_DIR}/tflint.zip" > "${BIN_DIR}/tflint-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/tflint-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/tflint.zip"
