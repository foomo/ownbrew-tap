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

case $arch in
amd64) arch_alias="x86_64";;
arm64) arch_alias="arm64";;
esac

info "downloading ..."
curl -fL "https://github.com/dadav/helm-schema/releases/download/${version}/helm-schema_${version}_${os_alias}_${arch_alias}.tar.gz" -o "${TEMP_DIR}/helm-schema.tar.gz"
curl -fL "https://github.com/dadav/helm-schema/releases/download/${version}/checksums.txt" -o "${TEMP_DIR}/helm-schema.tar.gz.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/helm-schema.tar.gz.sha256" | grep "helm-schema_${version}_${os_alias}_${arch_alias}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/helm-schema.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/helm-schema.tar.gz" -C "${TEMP_DIR}" helm-schema
mv -f "${TEMP_DIR}/helm-schema" "${BIN_DIR}/helm-schema-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/helm-schema-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/helm-schema.tar.gz" "${TEMP_DIR}/helm-schema.tar.gz.sha256"
