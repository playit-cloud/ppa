#!/usr/bin/env bash
set -euo pipefail

missing=()

check_command() {
  local command_name="$1"

  if ! command -v "${command_name}" >/dev/null 2>&1; then
    missing+=("${command_name}")
  fi
}

check_command curl
check_command dpkg-scanpackages
check_command apt-ftparchive
check_command gpg
check_command createrepo_c
check_command rpm
check_command apk
check_command abuild-sign
check_command openssl

if [ "${#missing[@]}" -eq 0 ]; then
  echo "all required tools are available"
  exit 0
fi

echo "missing required tools:" >&2
for command_name in "${missing[@]}"; do
  echo "  - ${command_name}" >&2
done

cat >&2 <<'EOF'

Install hints:
  Debian/Ubuntu:
    sudo apt install curl dpkg-dev apt-utils gnupg createrepo-c rpm openssl

  Fedora:
    sudo dnf install curl dpkg-dev apt createrepo_c rpm gnupg2 apk-tools abuild openssl

  Alpine:
    sudo apk add curl dpkg apt createrepo_c rpm gnupg apk-tools abuild openssl

Some package names vary by distribution. Re-run scripts/check-deps.sh after installing tools.
EOF

exit 1
