#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/terraform-linters/tflint/releases/download/v${version}/tflint_${os}_${arch}.zip" -o "${TEMP_DIR}/tflint.zip"
curl -fL "https://github.com/terraform-linters/tflint/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/tflint.sha256"

# validate
echo "$(cat "${TEMP_DIR}/tflint.sha256" | grep "tflint_${os}_${arch}.zip" | awk '{print $1;}')  ${TEMP_DIR}/tflint.zip" | shasum -a 256 --check --quiet

# extract
unzip -p "${TEMP_DIR}/tflint.zip" > "${BIN_DIR}/tflint-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/tflint-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/tflint.zip"
