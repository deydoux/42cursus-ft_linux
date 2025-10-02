```sh
apt-get install -y build-essential bison curl gawk texinfo vim
export LFS_PART=/dev/sdb
mkfs -v -t ext4 $LFS_PART
export LFS=/mnt/lfs
umask 022 # file mode 0666 - 0022 = 0644; dir mode 0777 - 0022 = 0755
mkdir -pv $LFS
mount -v -t ext4 $LFS_PART $LFS
curl -O https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.16.10.tar.xz
tar -xvf linux-6.16.10.tar.xz
```
