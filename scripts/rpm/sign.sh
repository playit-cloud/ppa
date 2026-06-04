#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT=$(cd -- "${SCRIPT_DIR}/../.." &>/dev/null && pwd)
ARCHES=(x86_64 aarch64 armv7hl i386)
RPM_GPG_KEY="${RPM_GPG_KEY:-DA6CD75EC2839680}"

for arch in "${ARCHES[@]}"; do
  repo_dir="${REPO_ROOT}/rpm/${arch}"
  metadata="${repo_dir}/repodata/repomd.xml"

  if [ ! -f "${metadata}" ]; then
    echo "missing RPM repository metadata: rpm/${arch}/repodata/repomd.xml" >&2
    exit 1
  fi

  shopt -s nullglob
  packages=("${repo_dir}"/*.rpm)
  shopt -u nullglob

  if [ "${#packages[@]}" -eq 0 ]; then
    echo "missing RPM packages in rpm/${arch}" >&2
    exit 1
  fi

  for package in "${packages[@]}"; do
    if ! check_output=$(rpm --checksig "${package}" 2>&1); then
      echo "failed to verify RPM package signature: ${package}" >&2
      echo "${check_output}" >&2
      exit 1
    fi

    if ! grep -q "signatures OK" <<<"${check_output}"; then
      echo "RPM package is not signed: ${package}" >&2
      echo "${check_output}" >&2
      exit 1
    fi
  done

  echo "signing rpm/${arch}/repodata/repomd.xml"
  (
    cd "${repo_dir}"
    gpg --local-user "${RPM_GPG_KEY}" --detach-sign --armor repodata/repomd.xml
  )
done
