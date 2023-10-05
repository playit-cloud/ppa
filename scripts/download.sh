SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

VERSION="$1"

if [ -z "$VERSION" ]; then
  echo "missing verison"
  exit 1;
fi

curl -L -o "${SCRIPT_DIR}/../data/playit_${VERSION}_amd64.deb" https://github.com/playit-cloud/playit-agent/releases/download/v${VERSION}/playit_amd64.deb
curl -L -o "${SCRIPT_DIR}/../data/playit_${VERSION}_arm64.deb" https://github.com/playit-cloud/playit-agent/releases/download/v${VERSION}/playit_arm64.deb
curl -L -o "${SCRIPT_DIR}/../data/playit_${VERSION}_armhf.deb" https://github.com/playit-cloud/playit-agent/releases/download/v${VERSION}/playit_armhf.deb
curl -L -o "${SCRIPT_DIR}/../data/playit_${VERSION}_i386.deb" https://github.com/playit-cloud/playit-agent/releases/download/v${VERSION}/playit_i386.deb
curl -L -o "${SCRIPT_DIR}/../data/playit_${VERSION}_mipsel.deb" https://github.com/playit-cloud/playit-agent/releases/download/v${VERSION}/playit_mipsel.deb
curl -L -o "${SCRIPT_DIR}/../data/playit_${VERSION}_mips.deb" https://github.com/playit-cloud/playit-agent/releases/download/v${VERSION}/playit_mips.deb
