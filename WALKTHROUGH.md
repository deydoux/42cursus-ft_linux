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
mkfs -v -t ext4 $LFS_PART
```

#### Setting the $LFS Variable and the Umask
`umask` set default mode/permission for new files and directories:
- File: 0666 - 0022 = 0644
- Directory: 0777 - 0022 = 0755
```sh
export LFS=/mnt/lfs
umask 022
```

#### Mounting the New Partition
```sh
mkdir -pv $LFS
mount -v -t ext4 $LFS_PART $LFS
```

### Packages and Patches
```sh
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

wget https://linuxfromscratch.org/lfs/view/stable/wget-list-sysv
wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources

pushd $LFS/sources
wget https://linuxfromscratch.org/lfs/view/stable/md5sums
md5sum -c md5sums
popd
```

### Final Preparations
#### Creating a Limited Directory Layout in the LFS Filesystem

