#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $arch in
amd64) arch_alias="x86_64";;
arm64) arch_alias="arm64";;
esac

case $os in
linux)
  format="tgz"
  os_alias="ubuntu2204"
  ;;
darwin)
  format="zip"
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
curl -fL "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-${os_alias}-${arch_alias}-${version}.${format}" -o "${TEMP_DIR}/mongotools.${format}"

info "extracting ..."
case $format in
tgz)
  mkdir "${TEMP_DIR}/mongotools"
  tar -xzvf "${TEMP_DIR}/mongotools.tgz" --strip-components=1 -C "${TEMP_DIR}/mongotools"
  ;;
zip)
  unzip "${TEMP_DIR}/mongotools.zip" -d "${TEMP_DIR}"
  mv -f "${TEMP_DIR}/mongodb-database-tools-${os_alias}-${arch_alias}-${version}" "${TEMP_DIR}/mongotools"
  ;;
esac

mv -f "${TEMP_DIR}/mongotools/bin/bsondump" "${BIN_DIR}/bsondump-${version}-${os}-${arch}"
mv -f "${TEMP_DIR}/mongotools/bin/mongodump" "${BIN_DIR}/mongodump-${version}-${os}-${arch}"
mv -f "${TEMP_DIR}/mongotools/bin/mongoexport" "${BIN_DIR}/mongoexport-${version}-${os}-${arch}"
mv -f "${TEMP_DIR}/mongotools/bin/mongofiles" "${BIN_DIR}/mongofiles-${version}-${os}-${arch}"
mv -f "${TEMP_DIR}/mongotools/bin/mongoimport" "${BIN_DIR}/mongoimport-${version}-${os}-${arch}"
mv -f "${TEMP_DIR}/mongotools/bin/mongorestore" "${BIN_DIR}/mongorestore-${version}-${os}-${arch}"
mv -f "${TEMP_DIR}/mongotools/bin/mongostat" "${BIN_DIR}/mongostat-${version}-${os}-${arch}"
mv -f "${TEMP_DIR}/mongotools/bin/mongotop" "${BIN_DIR}/mongotop-${version}-${os}-${arch}"

chmod a+x "${BIN_DIR}/bsondump-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongodump-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongoexport-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongofiles-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongoimport-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongorestore-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongostat-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongotop-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/mongotools.${format}" && rm -rf "${TEMP_DIR}/mongotools"
