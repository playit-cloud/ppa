#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
REPO_ROOT=$(cd -- "${SCRIPT_DIR}/../.." &>/dev/null && pwd)

VERSION="${1:-}"

if [ -z "${VERSION}" ]; then
  echo "missing version" >&2
  exit 1
fi

BASE_URL="https://github.com/playit-cloud/playit-agent/releases/download/v${VERSION}"
ARCHES=(x86_64 aarch64 armv7hl i386)

for arch in "${ARCHES[@]}"; do
  asset="playit_${arch}.rpm"
  output_dir="${REPO_ROOT}/rpm/${arch}"
  output="${output_dir}/playit_${VERSION}_${arch}.rpm"
  partial="${output}.part"

  mkdir -p "${output_dir}"

  echo "downloading ${asset}"
  if ! curl -fL -o "${partial}" "${BASE_URL}/${asset}"; then
    rm -f "${partial}"
    echo "missing RPM asset: ${asset} for v${VERSION}" >&2
    exit 1
  fi

  mv "${partial}" "${output}"
done
