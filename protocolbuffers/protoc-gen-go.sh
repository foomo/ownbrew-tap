#!/bin/sh
# https://github.com/protocolbuffers/protobuf-go

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# TODO remove once supported
if [ "$arch" = "arm64" ]
then
	echo "WARN: using amd64 version"
	arch_alias="amd64"
fi

# download
curl -fL "https://github.com/protocolbuffers/protobuf-go/releases/download/v${version}/protoc-gen-go.v${version}.${os}.${arch_alias}.tar.gz" -o "${TEMP_DIR}/protoc-gen-go.tar.gz"

# extract
tar -xzvf "${TEMP_DIR}/protoc-gen-go.tar.gz" -C "${TEMP_DIR}" protoc-gen-go
mv "${TEMP_DIR}/protoc-gen-go" "bin/protoc-gen-go-${version}-${os}-${arch}"
chmod a+x "bin/protoc-gen-go-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/protoc-gen-go.tar.gz"
