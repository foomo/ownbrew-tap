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

# TODO remove once supported
if [ "$arch" = "arm64" ]
then
	warn "WARN: using amd64 version"
	arch_alias="amd64"
else
	arch_alias="amd64"
fi

info "downloading ..."
curl -fL "https://github.com/szkiba/xk6-dashboard/releases/download/v${version}/xk6-dashboard_v${version}_${os}_${arch_alias}.tar.gz" -o "${TEMP_DIR}/xk6-dashboard.tar.gz"

info "extracting ..."
tar -xzvf "${TEMP_DIR}/xk6-dashboard.tar.gz" -C "${TEMP_DIR}" k6
mv -f "${TEMP_DIR}/k6" "${BIN_DIR}/k6-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/k6-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/xk6-dashboard.tar.gz"
