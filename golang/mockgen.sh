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

echo "DEPRECATED: use uber-go/mock"

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

info "downloading ..."
curl -fL "https://github.com/golang/mock/releases/download/v${version}/mock_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/mockgen.tar.gz"
curl -fL "https://github.com/golang/mock/releases/download/v${version}/mock_${version}_checksums.txt" -o "${TEMP_DIR}/mockgen.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/mockgen.sha256" | grep "mock_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/mockgen.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/mockgen.tar.gz" -C "${TEMP_DIR}" --strip-components=1 "mock_${version}_${os}_${arch}/mockgen"
mv -f "${TEMP_DIR}/mockgen" "${BIN_DIR}/mockgen-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mockgen-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/mockgen.tar.gz" "${TEMP_DIR}/mockgen.sha256"
