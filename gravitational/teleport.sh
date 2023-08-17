#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
arch_alias="${arch}"
version="${version:-${3}}"

if [[ $os = "darwin" ]] && [[ $arch = "arm64" ]] && [[ $version = 12* ]]
then
  warn "WARN: using amd64 version < v13.0.0"
  arch_alias="amd64"
fi

info "downloading ..."
curl -sfL "https://cdn.teleport.dev/teleport-v${version}-${os}-${arch_alias}-bin.tar.gz" -o "${TEMP_DIR}/teleport.tar.gz"

info "extracting ..."
tar -xzvf "${TEMP_DIR}/teleport.tar.gz" -C "${TEMP_DIR}" teleport

mv -f "${TEMP_DIR}/teleport/tbot" "${BIN_DIR}/tbot-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/tbot-${version}-${os}-${arch}"

mv -f "${TEMP_DIR}/teleport/tctl" "${BIN_DIR}/tctl-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/tctl-${version}-${os}-${arch}"

mv -f "${TEMP_DIR}/teleport/teleport" "${BIN_DIR}/teleport-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/teleport-${version}-${os}-${arch}"

mv -f "${TEMP_DIR}/teleport/tsh" "${BIN_DIR}/tsh-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/tsh-${version}-${os}-${arch}"

info "cleanup ..."
rm -rf "${TEMP_DIR}/teleport.tar.gz" "${TEMP_DIR}/teleport"
