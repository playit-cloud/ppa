#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

"${SCRIPT_DIR}/debian/sign.sh"
"${SCRIPT_DIR}/rpm/sign.sh"
"${SCRIPT_DIR}/alpine/sign.sh"
