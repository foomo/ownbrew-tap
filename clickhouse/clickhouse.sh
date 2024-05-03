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
# os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $arch in
amd64) arch_alias="";;
arm64) arch_alias="aarch64";;
esac

# https://github.com/ClickHouse/ClickHouse/releases/download/v24.4.1.2088-stable/clickhouse-macos
# https://github.com/ClickHouse/ClickHouse/releases/download/v24.4.1.2088-stable/clickhouse-macos-aarch64

url="https://github.com/ClickHouse/ClickHouse/releases/download/${version}/clickhouse-macos-${arch_alias}"


info "downloading ..."
echo $url
curl -fL "https://github.com/ClickHouse/ClickHouse/releases/download/${version}/clickhouse-macos-${arch_alias}" -o "${BIN_DIR}/clickhouse-macos-${version}-${arch}" --create-dirs

chmod a+x "${BIN_DIR}/clickhouse-macos"
