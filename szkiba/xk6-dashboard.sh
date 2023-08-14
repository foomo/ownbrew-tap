#!/usr/bin/env bash

set -e

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"

# TODO remove once supported
if [ "$arch" = "arm64" ]
then
	echo "WARN: using amd64 version"
	arch_alias="amd64"
else
	arch_alias="amd64"
fi

# download
curl -fL "https://github.com/szkiba/xk6-dashboard/releases/download/v${version}/xk6-dashboard_v${version}_${os}_${arch_alias}.tar.gz" -o "${TEMP_DIR}/xk6-dashboard.tar.gz"

# extract
tar -xzvf "${TEMP_DIR}/xk6-dashboard.tar.gz" -C "${TEMP_DIR}" k6
mv "${TEMP_DIR}/k6" "${BIN_DIR}/k6-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/k6-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/xk6-dashboard.tar.gz"
