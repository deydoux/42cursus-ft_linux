# Linux From Scratch
## Preparing for the Build
### Preparing the Host System
#### Host System Requirements
```sh
apt-get install -y bison build-essential gawk python3 texinfo wget
ln -sfv /usr/bin/bash /usr/bin/sh
```

#### Creating a File System on the Partition
```sh
export LFS_PART=/dev/sdb
```
```sh
mkfs -v -t ext4 $LFS_PART
```

#### Setting the $LFS Variable and the Umask
```sh
export LFS=/mnt/lfs
```
```sh
umask 022
```
`umask` set default mode/permission for new files and directories:
- File: 0666 - 0022 = 0644
- Directory: 0777 - 0022 = 0755

#### Mounting the New Partition
```sh
mkdir -pv $LFS
mount -v -t ext4 $LFS_PART $LFS
```

### Packages and Patches
```sh
mkdir -v $LFS/sources
```
```sh
chmod -v a+wt $LFS/sources
```
```sh
wget https://linuxfromscratch.org/lfs/view/stable/wget-list-sysv
```
```sh
wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources
```
```sh
pushd $LFS/sources
	wget https://linuxfromscratch.org/lfs/view/stable/md5sums
	md5sum -c md5sums
popd
```

### Final Preparations
#### Creating a Limited Directory Layout in the LFS Filesystem
```sh
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac
```
```sh
mkdir -pv $LFS/tools
```

#### Adding the LFS User
```sh
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
```
```sh
chown -v lfs $LFS/{usr{,/*},var,etc,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac
```
```sh
su - lfs
```

#### Setting Up the Environment
```sh
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF
```
```sh
cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF
```
---
**Must be done as root**
```sh
[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
```
---
```sh
cat >> ~/.bashrc << "EOF"
export MAKEFLAGS=-j$(nproc)
EOF
```
```sh
source ~/.bash_profile
```
