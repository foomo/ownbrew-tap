#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# TODO remove once supported
if [ "$os" = "darwin" ] && [ "$arch" = "arm64" ]
then
	echo "WARN: using amd64 version"
	arch_alias="amd64"
else
	arch_alias="arm64"
fi

# download
curl -fL "https://github.com/c-bata/kube-prompt/releases/download/v${version}/kube-prompt_v${version}_${os}_${arch_alias}.zip" -o "${TEMP_DIR}/kube-prompt.zip"

# extract
unzip -p "${TEMP_DIR}/kube-prompt.zip" > "${BIN_DIR}/kube-prompt-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/kube-prompt-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/kube-prompt.zip"

