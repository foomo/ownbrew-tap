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
curl -fL "https://github.com/grpc/grpc-go/releases/download/cmd%2Fprotoc-gen-go-grpc%2Fv${version}/protoc-gen-go-grpc.v${version}.${os}.${arch_alias}.tar.gz" -o "${TEMP_DIR}/protoc-gen-go-grpc.tar.gz"

# extract
tar -xzvf "${TEMP_DIR}/protoc-gen-go-grpc.tar.gz" -C "${TEMP_DIR}" protoc-gen-go-grpc
mv "${TEMP_DIR}/protoc-gen-go-grpc" "bin/protoc-gen-go-grpc-${version}-${os}-${arch}"
chmod a+x "bin/protoc-gen-go-grpc-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/protoc-gen-go-grpc.tar.gz"

