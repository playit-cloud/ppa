#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT=$(cd -- "${SCRIPT_DIR}/../.." &>/dev/null && pwd)
ARCHES=(x86_64 aarch64 armv7hl i386)

for arch in "${ARCHES[@]}"; do
  repo_dir="${REPO_ROOT}/rpm/${arch}"

  if [ ! -d "${repo_dir}" ]; then
    echo "missing RPM repository directory: rpm/${arch}" >&2
    exit 1
  fi

  shopt -s nullglob
  packages=("${repo_dir}"/*.rpm)
  shopt -u nullglob

  if [ "${#packages[@]}" -eq 0 ]; then
    echo "missing RPM packages in rpm/${arch}" >&2
    exit 1
  fi

  echo "updating rpm/${arch}"
  (
    cd "${repo_dir}"
    createrepo_c --update .
  )
done
