#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

info "downloading ..."
curl -fL "https://github.com/loft-sh/vcluster/releases/download/v${version}/vcluster-${os}-${arch}" -o "${TEMP_DIR}/vcluster"
curl -fL "https://github.com/loft-sh/vcluster/releases/download/v${version}/vcluster-${os}-${arch}.sha256" -o "${TEMP_DIR}/vcluster.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/vcluster.sha256")  ${TEMP_DIR}/vcluster" | shasum -a 256 --check --strict --quiet

info "extracting ..."
mv -f "${TEMP_DIR}/vcluster" "${BIN_DIR}/vcluster-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/vcluster-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/vcluster.sha256"
