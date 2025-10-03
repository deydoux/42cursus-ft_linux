# Linux From Scratch
## Preparing for the Build
### Preparing the Host System
**Host System Requirements**
```sh
apt-get install -y build-essential bison gawk texinfo
```

Additional packages for a fresh Debian installation
```sh
apt-get install -y vim wget
```

**Creating a File System on the Partition**
```sh
export LFS_PART=/dev/sdb
mkfs -v -t ext4 $LFS_PART
```

**Setting the $LFS Variable and the Umask**

`umask` set default mode/permission for new files and directories:
- File: 0666 - 0022 = 0644
- Directory: 0777 - 0022 = 0755

```sh
export LFS=/mnt/lfs
umask 022
```

**Mounting the New Partition**
```sh
mkdir -pv $LFS
mount -v -t ext4 $LFS_PART $LFS
```
