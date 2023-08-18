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

case $os in
linux)
	archive="tar.gz"
	os_alias="linux"
	;;
darwin)
	archive="zip"
	os_alias="macos"
	;;
esac

info "downloading ..."
curl -fL "https://github.com/grafana/k6/releases/download/v${version}/k6-v${version}-${os_alias}-${arch}.${archive}" -o "${TEMP_DIR}/k6.${archive}"
curl -fL "https://github.com/grafana/k6/releases/download/v${version}/k6-v${version}-checksums.txt" -o "${TEMP_DIR}/k6.${archive}.sha256"

info "validating ..."
echo "$(cat "${TEMP_DIR}/k6.${archive}.sha256" | grep "k6-v${version}-${os_alias}-${arch}.${archive}" | awk '{print $1;}')  ${TEMP_DIR}/k6.${archive}" | shasum -a 256 --check --quiet

info "extracting ..."
if [ "${archive}" == "tar.gz" ]; then
	tar -xzvf "${TEMP_DIR}/k6.${archive}" -C "${TEMP_DIR}"
else
	unzip "${TEMP_DIR}/k6.${archive}" -d "${TEMP_DIR}"
fi
mv -f "${TEMP_DIR}/k6-v${version}-${os_alias}-${arch}/k6" "${BIN_DIR}/k6-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/k6-${version}-${os}-${arch}"

info "cleanup ..."
rm "${TEMP_DIR}/k6.${archive}" "${TEMP_DIR}/k6.${archive}.sha256"
rmdir "${TEMP_DIR}/k6-v${version}-${os_alias}-${arch}"
