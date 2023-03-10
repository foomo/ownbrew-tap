#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $arch in
amd64) arch_alias="x86_64";;
arm64) arch_alias="arm64";;
esac

# download
curl -fL "https://github.com/mfridman/tparse/releases/download/v${version}/tparse_${os}_${arch_alias}" -o "${TEMP_DIR}/tparse"
curl -fL "https://github.com/mfridman/tparse/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/tparse.sha256"

# validate
echo "$(cat ${TEMP_DIR}/tparse.sha256 | grep "tparse_${os}_${arch_alias}" | awk '{print $1;}')  ${TEMP_DIR}/tparse" | shasum -a 256 --check --quiet

# extract
mv "${TEMP_DIR}/tparse" "${TEMP_DIR}/tparse-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/tparse-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/tparse.sha256"
