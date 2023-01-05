#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://github.com/golang/mock/releases/download/v${version}/mock_${version}_${os}_${arch}.tar.gz" -o "${TEMP_DIR}/mockgen.tar.gz"
curl -fL "https://github.com/golang/mock/releases/download/v${version}/mock_${version}_checksums.txt" -o "${TEMP_DIR}/mockgen.sha256"

# validate
echo "$(cat "${TEMP_DIR}/mockgen.sha256" | grep "mock_${version}_${os}_${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/mockgen.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/mockgen.tar.gz" -C "${TEMP_DIR}" --strip-components=1 "mock_${version}_${os}_${arch}/mockgen"
mv "${TEMP_DIR}/mockgen" "${BIN_DIR}/mockgen-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/mockgen-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/mockgen.tar.gz" "${TEMP_DIR}/mockgen.sha256"
