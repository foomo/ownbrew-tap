#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

info "downloading ..."
curl -fL "https://github.com/gruntwork-io/terragrunt/releases/download/v${version}/terragrunt_${os}_${arch}" -o "${BIN_DIR}/terragrunt-${version}-${os}-${arch}"

info "extracting ..."
chmod +x "${BIN_DIR}/terragrunt-${version}-${os}-${arch}"
