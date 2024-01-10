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

case $arch in
amd64) arch_alias="x64";;
arm64) arch_alias="arm64";;
esac

info "downloading ..."
curl -fL "https://github.com/pulumi/pulumi/releases/download/v${version}/pulumi-v${version}-${os}-${arch_alias}.tar.gz" -o "${TEMP_DIR}/pulumi.tar.gz"
curl -fL "https://github.com/pulumi/pulumi/releases/download/v${version}/pulumi-${version}-checksums.txt" -o "${TEMP_DIR}/pulumi.tar.gz.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/pulumi.tar.gz.sha256" | grep "pulumi-v${version}-${os}-${arch_alias}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/pulumi.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/pulumi.tar.gz" -C "${TEMP_DIR}" pulumi
for value in pulumi pulumi-language-dotnet pulumi-language-nodejs pulumi-language-yaml pulumi-watch pulumi-analyzer-policy pulumi-language-go pulumi-language-python pulumi-resource-pulumi-nodejs pulumi-analyzer-policy-python pulumi-language-java pulumi-language-python-exec pulumi-resource-pulumi-python
do
  mv -f "${TEMP_DIR}/pulumi/${value}" "${BIN_DIR}/${value}-${version}-${os}-${arch}"
  chmod a+x "${BIN_DIR}/${value}-${version}-${os}-${arch}"
done

info "cleanup ..."
rm -rf "${TEMP_DIR}/pulumi.tar.gz" "${TEMP_DIR}/pulumi.tar.gz.sha256" "${TEMP_DIR}/pulumi"
