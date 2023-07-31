#!/usr/bin/env bash

set -e

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
	arch_alias="${arch_alias}-ubuntu2204"
	;;
darwin)
	path="osx/mongodb"
	os_alias="macos"
	;;
esac

# TODO remove once supported
if [ "$os" = "darwin" ] && [ "$arch" = "arm64" ]
then
	echo "WARN: using amd64 version"
	arch_alias="x86_64"
fi

# download
curl -fL "https://fastdl.mongodb.org/${path}-${os_alias}-${arch_alias}-${version}.tgz" -o "${TEMP_DIR}/mongo.tgz"

# extract
mkdir "${TEMP_DIR}/mongo"
tar -xzvf "${TEMP_DIR}/mongo.tgz" --strip-components=1 -C "${TEMP_DIR}/mongo"
mv "${TEMP_DIR}/mongo/bin/mongo" "${BIN_DIR}/mongo-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongo-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/mongo.tgz" && rm -rf "${TEMP_DIR}/mongo"
