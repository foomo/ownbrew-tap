#!/usr/bin/env bash

set -e

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
# TODO switch to deepmap once releases are made
curl -fL "https://github.com/franklinkim/oapi-codegen/releases/download/v${version}/oapi-codegen_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/oapi-codegen.tar.gz"
curl -fL "https://github.com/franklinkim/oapi-codegen/releases/download/v${version}/oapi-codegen_${version}_checksums.txt" -o "${TEMP_DIR}/oapi-codegen.tar.gz.sha256"

# validate
echo "$(cat "${TEMP_DIR}/oapi-codegen.tar.gz.sha256" | grep "oapi-codegen_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/oapi-codegen.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/oapi-codegen.tar.gz" -C "${TEMP_DIR}" oapi-codegen
mv "${TEMP_DIR}/oapi-codegen" "${BIN_DIR}/oapi-codegen-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/oapi-codegen-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/oapi-codegen.tar.gz" "${TEMP_DIR}/oapi-codegen.tar.gz.sha256"
