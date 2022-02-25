SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "${SCRIPT_DIR}/../data"

gpg -a -o Release.pgp --detach-sig Release
gpg -a -o InRelease --clearsign Release
