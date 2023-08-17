#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

info "downloading ..."
curl -fL "https://releases.hashicorp.com/terraform/${version}/terraform_${version}_${os}_${arch}.zip" -o "${TEMP_DIR}/terraform.zip"

info "extracting ..."
unzip -p "${TEMP_DIR}/terraform.zip" > "${BIN_DIR}/terraform-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/terraform-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/terraform.zip"
