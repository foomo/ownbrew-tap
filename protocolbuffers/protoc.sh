#!/bin/sh
# https://github.com/protocolbuffers/protobuf

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $os in
linux) os_alias="linux";;
darwin) os_alias="osx";;
esac

# TODO remove once supported
if [ "$arch" = "arm64" ]
then
	echo "WARN: using amd64 version"
	arch_alias="x86_64"
else
	arch_alias="x86_64"
fi

# download
curl -fL "https://github.com/protocolbuffers/protobuf/releases/download/v${version}/protoc-${version}-${os_alias}-${arch_alias}.zip" -o "${TEMP_DIR}/protoc.zip"

# extract
unzip -p "${TEMP_DIR}/protoc.zip bin/protoc"  > "${BIN_DIR}/protoc-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/protoc-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/protoc.zip"
