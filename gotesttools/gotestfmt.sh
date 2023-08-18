#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

info "downloading ..."
curl -fL "https://github.com/GoTestTools/gotestfmt/releases/download/v${version}/gotestfmt_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/gotestfmt.tar.gz"
curl -fL "https://github.com/GoTestTools/gotestfmt/releases/download/v${version}/gotestfmt_${version}_checksums.txt" -o "${TEMP_DIR}/gotestfmt.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/gotestfmt.sha256" | grep "gotestfmt_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/gotestfmt.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/gotestfmt.tar.gz" -C "${TEMP_DIR}" gotestfmt
mv -f "${TEMP_DIR}/gotestfmt" "${BIN_DIR}/gotestfmt-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/gotestfmt-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/gotestfmt.tar.gz" "${TEMP_DIR}/gotestfmt.sha256"
