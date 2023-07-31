#!/usr/bin/env bash

set -e

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -sfL "https://github.com/foomo/gotsrpc/releases/download/v${version}/gotsrpc_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/gotsrpc.tar.gz"
curl -sfL "https://github.com/foomo/gotsrpc/releases/download/v${version}/gotsrpc_${version}_checksums.txt" -o "${TEMP_DIR}/gotsrpc.tar.gz.sha256"

# validate
echo "$(cat "${TEMP_DIR}/gotsrpc.tar.gz.sha256" | grep "gotsrpc_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/gotsrpc.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/gotsrpc.tar.gz" -C "${TEMP_DIR}" gotsrpc
mv "${TEMP_DIR}/gotsrpc" "${BIN_DIR}/gotsrpc-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/gotsrpc-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/gotsrpc.tar.gz" "${TEMP_DIR}/gotsrpc.tar.gz.sha256"
