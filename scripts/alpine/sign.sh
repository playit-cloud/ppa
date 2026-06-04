#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT=$(cd -- "${SCRIPT_DIR}/../.." &>/dev/null && pwd)
ARCHES=(x86_64 aarch64 armv7 x86)

if [ -z "${ALPINE_SIGNING_KEY:-}" ]; then
  echo "missing required environment variable: ALPINE_SIGNING_KEY" >&2
  exit 1
fi

if [ -z "${ALPINE_SIGNING_KEY_NAME:-}" ]; then
  echo "missing required environment variable: ALPINE_SIGNING_KEY_NAME" >&2
  exit 1
fi

for arch in "${ARCHES[@]}"; do
  repo_dir="${REPO_ROOT}/alpine/stable/main/${arch}"
  index="${repo_dir}/APKINDEX.tar.gz"

  if [ ! -f "${index}" ]; then
    echo "missing Alpine repository index: alpine/stable/main/${arch}/APKINDEX.tar.gz" >&2
    exit 1
  fi

  echo "signing alpine/stable/main/${arch}/APKINDEX.tar.gz"
  abuild-sign -k "${ALPINE_SIGNING_KEY}" -p "${ALPINE_SIGNING_KEY_NAME}" "${index}"
done
