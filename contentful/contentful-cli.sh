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
darwin) os_alias="macos";;
esac

info "downloading ..."
curl -fL "https://github.com/contentful/contentful-cli/releases/download/v${version}/contentful-cli-${os_alias}-${version}.zip" -o "${TEMP_DIR}/contentful-cli.zip"

info "extracting ..."
unzip -p "${TEMP_DIR}/contentful-cli.zip" > "${BIN_DIR}/contentful-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/contentful-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/contentful-cli.zip"
