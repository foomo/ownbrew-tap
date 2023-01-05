#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/go-courier/husky/releases/download/v${version}/husky_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/husky.tar.gz"
curl -fL "https://github.com/go-courier/husky/releases/download/v${version}/husky_checksums.txt" -o "${TEMP_DIR}/husky.sha256"

# validate
echo "$(cat "${TEMP_DIR}/husky.sha256" | grep "husky_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/husky.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/husky.tar.gz" -C "${TEMP_DIR}" husky
mv "${TEMP_DIR}/husky" "${BIN_DIR}/husky-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/husky-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/husky.tar.gz" "${TEMP_DIR}/husky.sha256"
