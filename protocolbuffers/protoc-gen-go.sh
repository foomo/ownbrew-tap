#!/bin/bash
# https://github.com/protocolbuffers/protobuf-go

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
curl -fL "https://github.com/protocolbuffers/protobuf-go/releases/download/v${version}/protoc-gen-go.v${version}.${os}.${arch_alias}.tar.gz" -o "${TEMP_DIR}/protoc-gen-go.tar.gz"

info "extracting ..."
tar -xzvf "${TEMP_DIR}/protoc-gen-go.tar.gz" -C "${TEMP_DIR}" protoc-gen-go
mv -f "${TEMP_DIR}/protoc-gen-go" "${BIN_DIR}/protoc-gen-go-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/protoc-gen-go-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/protoc-gen-go.tar.gz"
