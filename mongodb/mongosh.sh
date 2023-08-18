#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $arch in
amd64) arch_alias="x64";;
arm64) arch_alias="arm64";;
esac

case $os in
linux) format="tgz";;
darwin) format="zip";;
esac

info "downloading ..."
curl -fL "https://downloads.mongodb.com/compass/mongosh-${version}-${os}-${arch_alias}.${format}" -o "${TEMP_DIR}/mongosh.${format}"


info "extracting ..."
case $format in
tgz)
  mkdir "${TEMP_DIR}/mongosh"
  tar -xzvf "${TEMP_DIR}/mongosh.tgz" --strip-components=1 -C "${TEMP_DIR}/mongosh"
  ;;
zip)
  unzip "${TEMP_DIR}/mongosh.zip" -d "${TEMP_DIR}"
  mv -f "${TEMP_DIR}/mongosh-${version}-${os}-${arch_alias}" "${TEMP_DIR}/mongosh"
  ;;
esac

mv -f "${TEMP_DIR}/mongosh/bin/mongosh" "${BIN_DIR}/mongosh-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mongosh-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/mongosh.${format}" && rm -rf "${TEMP_DIR}/mongosh"
