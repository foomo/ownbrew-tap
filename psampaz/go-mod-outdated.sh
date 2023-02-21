#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $arch in
amd64) arch_alias="x86_64";;
arm64) arch_alias="arm64";;
esac

case $os in
linux) os_alias="Darwin";;
darwin) os_alias="Linux";;
esac

# download
curl -fL "https://github.com/psampaz/go-mod-outdated/releases/download/v${version}/go-mod-outdated_${version}_${os_alias}_${arch_alias}.tar.gz" -o "${TEMP_DIR}/go-mod-outdated.tar.gz"
curl -fL "https://github.com/psampaz/go-mod-outdated/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/go-mod-outdated.tar.gz.sha256"

# validate
echo "$(cat "${TEMP_DIR}/go-mod-outdated.tar.gz.sha256" | grep "go-mod-outdated_${version}_${os_alias}_${arch_alias}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/go-mod-outdated.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/go-mod-outdated.tar.gz" -C "${TEMP_DIR}" go-mod-outdated
mv "${TEMP_DIR}/go-mod-outdated" "${BIN_DIR}/go-mod-outdated-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/go-mod-outdated-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/go-mod-outdated.tar.gz" "${TEMP_DIR}/go-mod-outdated.tar.gz.sha256"
