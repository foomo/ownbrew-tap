#!/usr/bin/env bash

set -e

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/foomo/logfrog/releases/download/v${version}/logfrog_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/logfrog.tar.gz"
curl -fL "https://github.com/foomo/logfrog/releases/download/v${version}/logfrog_${version}_checksums.txt" -o "${TEMP_DIR}/logfrog.tar.gz.sha256"

# validate
echo "$(cat "${TEMP_DIR}/logfrog.tar.gz.sha256" | grep "logfrog_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/logfrog.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/logfrog.tar.gz" -C "${TEMP_DIR}" logfrog
mv "${TEMP_DIR}/logfrog" "${BIN_DIR}/logfrog-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/logfrog-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/logfrog.tar.gz" "${TEMP_DIR}/logfrog.tar.gz.sha256"
