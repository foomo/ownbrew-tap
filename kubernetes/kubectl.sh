#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

info "downloading ...."
curl -fL "https://dl.k8s.io/release/v${version}/bin/${os}/${arch}/kubectl" -o "${TEMP_DIR}/kubectl"
curl -fL "https://dl.k8s.io/v${version}/bin/${os}/${arch}/kubectl.sha256" -o "${TEMP_DIR}/kubectl.sha256"

info "validating ...."
echo "$(cat "${TEMP_DIR}/kubectl.sha256")  ${TEMP_DIR}/kubectl" | shasum -a 256 --check --quiet

info "extracting ...."
mv -f "${TEMP_DIR}/kubectl" "${BIN_DIR}/kubectl-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/kubectl-${version}-${os}-${arch}"

info "cleanup ...."
rm -f "${TEMP_DIR}/kubectl.sha256"