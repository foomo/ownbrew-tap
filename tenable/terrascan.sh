#!/bin/bash

set -e

source .include/log.sh

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

case $os in
linux) os_alias="Linux";;
darwin) os_alias="Darwin";;
esac

# TODO remove once supported
if [ "$arch" = "arm64" ]
then
	warn "WARN: using amd64 version"
	arch_alias="x86_64"
else
	arch_alias="x86_64"
fi

info "downloading ..."
curl -fL "https://github.com/tenable/terrascan/releases/download/v${version}/terrascan_${version}_${os_alias}_${arch_alias}.tar.gz" -o "${TEMP_DIR}/terrascan.tar.gz"
curl -fL "https://github.com/tenable/terrascan/releases/download/v${version}/checksums.txt" -o "${TEMP_DIR}/terrascan.tar.gz.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/terrascan.tar.gz.sha256" | grep "terrascan_${version}_${os_alias}_${arch_alias}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/terrascan.tar.gz" | shasum -a 256 --check --quiet

info "extracting ..."
tar -xzvf "${TEMP_DIR}/terrascan.tar.gz" -C "${TEMP_DIR}" terrascan
mv -f "${TEMP_DIR}/terrascan" "${BIN_DIR}/terrascan-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/terrascan-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/terrascan.tar.gz" "${TEMP_DIR}/terrascan.tar.gz.sha256"
