#!/usr/bin/env bash

set -e

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/dreadl0ck/zeus/releases/download/v${version}/zeus_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/zeus.tar.gz"
curl -fL "https://github.com/dreadl0ck/zeus/releases/download/v${version}/zeus_${version}_checksums.txt" -o "${TEMP_DIR}/zeus.tar.gz.sha256"

# validate
echo "$(cat "${TEMP_DIR}/zeus.tar.gz.sha256" | grep "zeus_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/zeus.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/zeus.tar.gz" -C ./bin zeus
mv bin/zeus "${BIN_DIR}/zeus-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/zeus-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/zeus.tar.gz" "${TEMP_DIR}/zeus.tar.gz.sha256"
