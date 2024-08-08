SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "${SCRIPT_DIR}/../data"

gpg --local-user DA6CD75EC2839680 -a -o Release.pgp --detach-sig Release
gpg --local-user DA6CD75EC2839680 -a -o InRelease --clearsign Release
