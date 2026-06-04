#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

"${SCRIPT_DIR}/debian/update.sh"
"${SCRIPT_DIR}/rpm/update.sh"
"${SCRIPT_DIR}/alpine/update.sh"
