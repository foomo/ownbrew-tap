#!/usr/bin/env bash

set -e

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/stern/stern/releases/download/v${version}/stern_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/stern.tar.gz"
curl -fL "https://github.com/stern/stern/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/stern.tar.gz.sha256"

# validate
echo "$(cat "${TEMP_DIR}/stern.tar.gz.sha256" | grep "stern_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/stern.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/stern.tar.gz" -C "${TEMP_DIR}" stern
mv "${TEMP_DIR}/stern" "${BIN_DIR}/stern-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/stern-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/stern.tar.gz" "${TEMP_DIR}/stern.tar.gz.sha256"
