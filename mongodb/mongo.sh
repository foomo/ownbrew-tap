#!/bin/bash

set -e

# colors
CRed='\033[1;31m'
CGray='\033[0;37m'
CGreen='\033[1;32m'
CYellow='\033[1;33m'
NC='\033[0m'

# logging
info() {
  echo -e "${CGray}${1}${NC}"
}

warn() {
  echo -e "${CYellow}${1}${NC}"
}

error() {
  echo -e "${CRed}${1}${NC}"
}

success() {
  echo -e "${CGreen}${1}${NC}"
}

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $arch in
amd64) arch_alias="x86_64";;
arm64) arch_alias="aarch64";;
esac

case $os in
linux)
	path="linux/mongodb-shell"
	os_alias="linux"
	arch_alias="${arch_alias}-ubuntu2004"
	;;
darwin)
	path="osx/mongodb"
	os_alias="macos"
	;;
esac

# TODO remove once supported
if [ "$os" = "darwin" ] && [ "$arch" = "arm64" ]
then
	warn "WARN: using amd64 version"
	arch_alias="x86_64"
fi

info "downloading ..."
curl -fL "https://fastdl.mongodb.org/${path}-${os_alias}-${arch_alias}-${version}.tgz" -o "${TEMP_DIR}/mongo.tgz"

info "extracting ..."
mkdir "${TEMP_DIR}/mongo"
tar -xzvf "${TEMP_DIR}/mongo.tgz" --strip-components=1 -C "${TEMP_DIR}/mongo"
mv -f "${TEMP_DIR}/mongo/bin/mongo" "${BIN_DIR}/mongo-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongo-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/mongo.tgz" && rm -rf "${TEMP_DIR}/mongo"
