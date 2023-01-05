#!/bin/sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $os in
linux) os_alias="linux";;
darwin) os_alias="macos";;
esac

# download
curl -fL "https://github.com/jondot/hygen/releases/download/v${version}/hygen.${os_alias}.v${version}.tar.gz" -o "${TEMP_DIR}/hygen.tar.gz"

# extract
tar -xzvf "${TEMP_DIR}/hygen.tar.gz" -C "${TEMP_DIR}" hygen
mv "${TEMP_DIR}/hygen" "${BIN_DIR}/hygen-${version}-${os}"
chmod a+x "${BIN_DIR}/hygen-${version}-${os}"

# cleanup
rm "${TEMP_DIR}/hygen.tar.gz"
