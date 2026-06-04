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

download_deb() {
  local arch="$1"
  local asset="playit_${arch}.deb"
  local output="${REPO_ROOT}/data/playit_${VERSION}_${arch}.deb"
  local partial="${output}.part"

  echo "downloading ${asset}"
  if ! curl -fL -o "${partial}" "${BASE_URL}/${asset}"; then
    rm -f "${partial}"
    echo "missing Debian asset: ${asset} for v${VERSION}" >&2
    exit 1
  fi

  mv "${partial}" "${output}"
}

download_deb amd64
download_deb arm64
download_deb armhf
download_deb i386
