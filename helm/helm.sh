#!/usr/bin/env bash

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# download
curl -fL "https://get.helm.sh/helm-v${version}-${os}-${arch}.tar.gz" -o "${TEMP_DIR}/helm.tar.gz"
curl -fL "https://get.helm.sh/helm-v${version}-${os}-${arch}.tar.gz.sha256sum" -o "${TEMP_DIR}/helm.tar.gz.sha256"

# validate
echo "$(cat "${TEMP_DIR}/helm.tar.gz.sha256" | grep "helm-v${version}-${os}-${arch}.tar.gz" | awk '{print $1;}')  ${TEMP_DIR}/helm.tar.gz" | shasum -a 256 --check --quiet

# extract
tar -xzvf "${TEMP_DIR}/helm.tar.gz" -C "${TEMP_DIR}" --strip-components=1 "${os}-${arch}/helm"
mv "${TEMP_DIR}/helm" "${BIN_DIR}/helm-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/helm-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/helm.tar.gz" "${TEMP_DIR}/helm.tar.gz.sha256"
