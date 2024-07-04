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
linux)
  warn "NOTE: Linux version is currently unavailable"
  exit 0
  ;;
darwin) os_alias="macos";;
esac

case $arch in
amd64) arch_alias="amd64";;
arm64) arch_alias="aarch64";;
esac

info "downloading ..."
curl -fL "https://github.com/ClickHouse/ClickHouse/releases/download/${version}/clickhouse-${os_alias}-${arch_alias}" -o "${BIN_DIR}/clickhouse-${os}-${version}-${arch}" --create-dirs

info "extracting ..."
chmod a+x "${BIN_DIR}/clickhouse-${os}-${version}-${arch}"
