#!/bin/bash
# https://github.com/grpc/grpc-go

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# TODO remove once supported
if [ "$arch" = "arm64" ]
then
	warn "WARN: using amd64 version"
	arch_alias="amd64"
else
	arch_alias="${arch}"
fi

info "downloading ..."
curl -fL "https://github.com/grpc/grpc-go/releases/download/cmd%2Fprotoc-gen-go-grpc%2Fv${version}/protoc-gen-go-grpc.v${version}.${os}.${arch_alias}.tar.gz" -o "${TEMP_DIR}/protoc-gen-go-grpc.tar.gz"

info "extracting ..."
tar -xzvf "${TEMP_DIR}/protoc-gen-go-grpc.tar.gz" -C "${TEMP_DIR}"
mv -f "${TEMP_DIR}/protoc-gen-go-grpc" "${BIN_DIR}/protoc-gen-go-grpc-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/protoc-gen-go-grpc-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/protoc-gen-go-grpc.tar.gz" "${TEMP_DIR}/LICENSE" "${TEMP_DIR}/README.md"
