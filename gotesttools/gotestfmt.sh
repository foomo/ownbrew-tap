#!/usr/bin/env bash

set -e

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/GoTestTools/gotestfmt/releases/download/v${version}/gotestfmt_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/gotestfmt"
curl -fL "https://github.com/GoTestTools/gotestfmt/releases/download/v${version}/gotestfmt_${version}_checksums.txt" -o "${TEMP_DIR}/gotestfmt.sha256"

# validate
echo "$(cat "${TEMP_DIR}/gotestfmt.sha256" | grep "gotestfmt_${version}_${os}_${arch}" | awk '{print $1;}')  ${TEMP_DIR}/gotestfmt" | shasum -a 256 --check --quiet

# extract
mv "${TEMP_DIR}/gotestfmt" "${BIN_DIR}/gotestfmt-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/gotestfmt-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/gotestfmt.sha256"