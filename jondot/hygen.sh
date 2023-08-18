#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $os in
linux) os_alias="linux";;
darwin) os_alias="macos";;
esac

# TODO remove once supported
if [ "$arch" = "arm64" ]
then
	warn "WARN: using amd64 version"
fi

info "downloading ..."
curl -fL "https://github.com/jondot/hygen/releases/download/v${version}/hygen.${os_alias}.v${version}.tar.gz" -o "${TEMP_DIR}/hygen.tar.gz"

info "extracting ..."
tar -xzvf "${TEMP_DIR}/hygen.tar.gz" -C "${TEMP_DIR}" hygen
mv -f "${TEMP_DIR}/hygen" "${BIN_DIR}/hygen-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/hygen-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/hygen.tar.gz"
