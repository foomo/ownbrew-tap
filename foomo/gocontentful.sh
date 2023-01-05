#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/foomo/gocontentful/releases/download/v${version}/gocontentful_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/gocontentful.tar.gz"
curl -fL "https://github.com/foomo/gocontentful/releases/download/v${version}/gocontentful_${version}_checksums.txt" -o "${TEMP_DIR}/gocontentful.tar.gz.sha256"

# validate
echo "$(cat "${TEMP_DIR}/gocontentful.tar.gz.sha256" | grep "gocontentful_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/gocontentful.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/gocontentful.tar.gz" -C "${TEMP_DIR}" gocontentful
mv "${TEMP_DIR}/gocontentful" "${BIN_DIR}/gocontentful-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/gocontentful-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/gocontentful.tar.gz" "${TEMP_DIR}/gocontentful.tar.gz.sha256"
