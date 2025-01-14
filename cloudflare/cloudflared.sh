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
if [ "$os" = "darwin" ]
then
  curl -fL "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}.tgz" -o "${TEMP_DIR}/cloudflared.tar.gz"
else
  curl -fL "https://github.com/cloudflare/cloudflared/releases/download/${version}/cloudflared-${os}-${arch}" -o "${TEMP_DIR}/cloudflared"
fi

info "extracting ..."
if [ "$os" = "darwin" ]
then
  tar -xzvf "${TEMP_DIR}/cloudflared.tar.gz" -C "${TEMP_DIR}" cloudflared
fi
mv -f "${TEMP_DIR}/cloudflared" "${BIN_DIR}/cloudflared-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/cloudflared-${version}-${os}-${arch}"

info "cleanup ..."
rm -f "${TEMP_DIR}/cloudflared.tar.gz"
