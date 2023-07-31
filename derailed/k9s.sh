#!/bin/bash

set -e

source ../include/semver.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $os in
linux) os_alias="Linux";;
darwin) os_alias="Darwin";;
esac

case $arch in
amd64)
  if semver_compare "${version}" "0.27.0"
  then
    arch_alias="x86_64"
  else
    arch_alias="amd64"
  fi
  ;;
arm64) arch_alias="arm64";;
esac

# download
curl -fL "https://github.com/derailed/k9s/releases/download/v${version}/k9s_${os_alias}_${arch_alias}.tar.gz" -o "${TEMP_DIR}/k9s.tar.gz"
curl -fL "https://github.com/derailed/k9s/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/k9s.tar.gz.sha256"

# validate
echo "$(cat ${TEMP_DIR}/k9s.tar.gz.sha256 | grep "k9s_${os_alias}_${arch_alias}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/k9s.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/k9s.tar.gz" -C "${TEMP_DIR}" k9s
mv "${TEMP_DIR}/k9s" "${BIN_DIR}/k9s-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/k9s-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/k9s.tar.gz" "${TEMP_DIR}/k9s.tar.gz.sha256"
