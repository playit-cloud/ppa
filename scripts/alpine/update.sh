#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT=$(cd -- "${SCRIPT_DIR}/../.." &>/dev/null && pwd)
ARCHES=(x86_64 aarch64 armv7 x86)

for arch in "${ARCHES[@]}"; do
  repo_dir="${REPO_ROOT}/alpine/stable/main/${arch}"

  if [ ! -d "${repo_dir}" ]; then
    echo "missing Alpine repository directory: alpine/stable/main/${arch}" >&2
    exit 1
  fi

  shopt -s nullglob
  packages=("${repo_dir}"/*.apk)
  shopt -u nullglob

  if [ "${#packages[@]}" -eq 0 ]; then
    echo "missing Alpine packages in alpine/stable/main/${arch}" >&2
    exit 1
  fi

  echo "updating alpine/stable/main/${arch}"
  (
    cd "${repo_dir}"
    apk index --rewrite-arch "${arch}" -o APKINDEX.tar.gz ./*.apk
  )
done
