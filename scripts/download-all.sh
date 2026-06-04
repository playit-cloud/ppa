#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
VERSION="${1:-}"

if [ -z "${VERSION}" ]; then
  echo "missing version" >&2
  exit 1
fi

"${SCRIPT_DIR}/debian/download.sh" "${VERSION}"
"${SCRIPT_DIR}/rpm/download.sh" "${VERSION}"
"${SCRIPT_DIR}/alpine/download.sh" "${VERSION}"
