#!/usr/bin/env bash
# Keep kubectl version in sync with the aws cluster version
# @see https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html

# vars
os="${os:-${1}}"
arch="${arch:-${2}}"
version="${version:-${3}}"
date="${date:-${4}}"

# TODO remove once supported
if [ "$os" = "darwin" ] && [ "$arch" = "arm64" ]
then
	echo "WARN: using amd64 version"
	arch_alias="amd64"
else
	arch_alias="arm64"
fi

# download
curl -fL "https://amazon-eks.s3.us-west-2.amazonaws.com/${version}/${date}/bin/${os}/${arch_alias}/kubectl" -o "${TEMP_DIR}/kubectl"
curl -fL "https://amazon-eks.s3.us-west-2.amazonaws.com/${version}/${date}/bin/${os}/${arch_alias}/kubectl.sha256" -o "${TEMP_DIR}/kubectl.sha256"

# validate
echo "$(cat "${TEMP_DIR}/kubectl.sha256" | awk '{print $1;}')  ${TEMP_DIR}/kubectl" | shasum -a 256 --check --quiet

mv "${TEMP_DIR}/kubectl" "${BIN_DIR}/kubectl-${version}-${os}-${arch}"
chmod a+x "${BIN_DIR}/kubectl-${version}-${os}-${arch}"

# cleanup
rm "${TEMP_DIR}/kubectl.sha256"
