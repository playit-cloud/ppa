## Official playit Package Repositories

### Debian / Ubuntu

To install playit on a Debian-based operating system, run:

```
curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | sudo tee /etc/apt/sources.list.d/playit-cloud.list
sudo apt update
sudo apt install playit
```

Getting a warning in apt about playit's repo? Run these commands:

```
sudo apt-key del '16AC CC32 BD41 5DCC 6F00  D548 DA6C D75E C283 9680'
sudo rm /etc/apt/sources.list.d/playit-cloud.list
sudo apt update

curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | sudo tee /etc/apt/sources.list.d/playit-cloud.list
sudo apt update
```

### Fedora

```
sudo curl -fsSL -o /etc/yum.repos.d/playit.repo https://playit-cloud.github.io/ppa/repo-files/playit-fedora.repo
sudo dnf install playit
```

### openSUSE

```
sudo zypper ar -f https://playit-cloud.github.io/ppa/repo-files/playit-opensuse.repo
sudo zypper refresh
sudo zypper install playit
```

### Alpine Linux

```
sudo wget -O /etc/apk/keys/playit.rsa.pub https://playit-cloud.github.io/ppa/alpine/playit.rsa.pub
echo "https://playit-cloud.github.io/ppa/alpine/stable/main" | sudo tee -a /etc/apk/repositories
sudo apk update
sudo apk add playit
```

### Maintainer Workflow

Download packages for a release:

```
scripts/download-all.sh 1.0.7-rc4
```

Regenerate repository metadata:

```
scripts/update-all.sh
```

Sign repository metadata:

```
scripts/sign-all.sh
```

The existing Debian repository remains in `data/` for backwards compatibility. Fedora and openSUSE share the RPM repository at `rpm/$basearch`. Alpine uses `alpine/stable/main`.

### Signing Keys

Debian and RPM repository metadata use `key.gpg`.

Alpine repository metadata uses the public key published at:

```
https://playit-cloud.github.io/ppa/alpine/playit.rsa.pub
```
