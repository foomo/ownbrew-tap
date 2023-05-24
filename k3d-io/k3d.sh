#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/k3d-io/k3d/releases/download/v${version}/k3d-${os}-${arch}" -o "${TEMP_DIR}/k3d"
curl -fL "https://github.com/k3d-io/k3d/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/k3d.sha256"

# validate
echo "$(cat "${TEMP_DIR}/k3d.sha256" | grep "k3d-${os}-${arch}" | awk '{print $1;}')  ${TEMP_DIR}/k3d" | shasum -a 256 --check --quiet

# extract
mv "${TEMP_DIR}/k3d" "${BIN_DIR}/k3d-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/k3d-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/k3d.sha256"
