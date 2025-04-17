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
linux) os_alias="linux" ;;
darwin) os_alias="darwin" ;;
esac

case $arch in
amd64) arch_alias="x86_64" ;;
arm64) arch_alias="arm64" ;;
esac

info "downloading ..."
curl -fL "https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v${version}/cloud-sql-proxy.${os_alias}.${arch_alias}" -o "${BIN_DIR}/cloud-sql-proxy-${version}-${os}-${arch}"

info "extracting ..."
chmod a+x "${BIN_DIR}/cloud-sql-proxy-${version}-${os}-${arch}"
