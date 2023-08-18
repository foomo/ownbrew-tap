#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

info "downloading ..."
curl -fL "https://github.com/golangci/golangci-lint/releases/download/v${version}/golangci-lint-${version}-${os}-${arch}.tar.gz" -o "${TEMP_DIR}/golangci-lint.tar.gz"
curl -fL "https://github.com/golangci/golangci-lint/releases/download/v${version}/golangci-lint-${version}-checksums.txt" -o "${TEMP_DIR}/golangci-lint.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/golangci-lint.sha256" | grep "golangci-lint-${version}-${os}-${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/golangci-lint.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/golangci-lint.tar.gz" -C "${TEMP_DIR}" --strip-component=1 "golangci-lint-${version}-${os}-${arch}/golangci-lint"
mv -f "${TEMP_DIR}/golangci-lint" "${BIN_DIR}/golangci-lint-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/golangci-lint-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/golangci-lint.tar.gz" "${TEMP_DIR}/golangci-lint.sha256"
