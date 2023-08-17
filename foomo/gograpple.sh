#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

info "downloading ..."
curl -fL "https://github.com/foomo/gograpple/releases/download/v${version}/gograpple_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/gograpple.tar.gz"
curl -fL "https://github.com/foomo/gograpple/releases/download/v${version}/gograpple_${version}_checksums.txt" -o "${TEMP_DIR}/gograpple.tar.gz.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/gograpple.tar.gz.sha256" | grep "gograpple_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/gograpple.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/gograpple.tar.gz" -C "${TEMP_DIR}" gograpple
mv -f "${TEMP_DIR}/gograpple" "${BIN_DIR}/gograpple-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/gograpple-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/gograpple.tar.gz" "${TEMP_DIR}/gograpple.tar.gz.sha256"
