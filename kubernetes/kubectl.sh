#!/usr/bin/env bash

set -e

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://dl.k8s.io/release/v${version}/bin/${os}/${arch}/kubectl" -o "${BIN_DIR}/kubectl-${version}-${os}-${arch}"

# extract
chmod a+x "${BIN_DIR}/kubectl-${version}-${os}-${arch}"
