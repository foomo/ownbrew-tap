#!/usr/bin/env bash
# Keep kubectl version in sync with the aws cluster version
# @see https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# TODO remove once supported
if [ "$os" = "linux" ] && [ "$arch" = "arm64" ]
then
	echo "WARN: using amd64 version"
	arch_alias="amd64"
else
	arch_alias="arm64"
fi

# download
curl -fL "https://github.com/kubernetes-sigs/hierarchical-namespaces/releases/download/v${version}/kubectl-hns_${os}_${arch_alias}" -o "${BIN_DIR}/kubectl-hns-${version}-${os}-${arch}"

# extract
chmod a+x "${BIN_DIR}/kubectl-hns-${version}-${os}-${arch}"


