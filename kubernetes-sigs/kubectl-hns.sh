#!/bin/bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# TODO remove once supported
if [ "$os" = "linux" ] && [ "$arch" = "arm64" ]
then
	warn "WARN: using amd64 version"
	arch_alias="amd64"
else
	arch_alias="${arch}"
fi

info "downloading ..."
curl -fL "https://github.com/kubernetes-sigs/hierarchical-namespaces/releases/download/v${version}/kubectl-hns_${os}_${arch_alias}" -o "${BIN_DIR}/kubectl-hns-${version}-${os}-${arch}"

info "extracting ..."
chmod a+x "${BIN_DIR}/kubectl-hns-${version}-${os}-${arch}"


