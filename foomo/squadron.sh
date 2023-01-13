#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/foomo/squadron/releases/download/v${version}/squadron_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/squadron.tar.gz"
curl -fL "https://github.com/foomo/squadron/releases/download/v${version}/squadron_${version}_checksums.txt" -o "${TEMP_DIR}/squadron.tar.gz.sha256"

# validate
echo "$(cat "${TEMP_DIR}/squadron.tar.gz.sha256" | grep "squadron_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/squadron.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/squadron.tar.gz" -C "${TEMP_DIR}" squadron
mv "${TEMP_DIR}/squadron" "${BIN_DIR}/squadron-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/squadron-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/squadron.tar.gz" "${TEMP_DIR}/squadron.tar.gz.sha256"
