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
linux) os_alias="Linux";;
darwin) os_alias="Darwin";;
esac

info "downloading ..."
curl -fL "https://github.com/derailed/k9s/releases/download/v${version}/k9s_${os_alias}_${arch}.tar.gz" -o "${TEMP_DIR}/k9s.tar.gz"
## changed name since v0.28.0
if [ $(curl -LI "https://github.com/derailed/k9s/releases/download/v${version}/checksums.txt" -o /dev/null -w '%{http_code}\n' -s) == "200" ]; then
  curl -L "https://github.com/derailed/k9s/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/k9s.tar.gz.sha256"
else
  curl -L "https://github.com/derailed/k9s/releases/download/v${version}/checksums.sha256" -o "${TEMP_DIR}/k9s.tar.gz.sha256"
fi

info "validating ..."
echo "$(cat ${TEMP_DIR}/k9s.tar.gz.sha256 | grep "k9s_${os_alias}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/k9s.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/k9s.tar.gz" -C "${TEMP_DIR}" k9s
mv -f "${TEMP_DIR}/k9s" "${BIN_DIR}/k9s-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/k9s-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/k9s.tar.gz" "${TEMP_DIR}/k9s.tar.gz.sha256"
