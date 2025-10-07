#!/bin/bash
set -x

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

MOUNTPOINT="$1"

if [ -z "$MOUNTPOINT" ]; then
	echo "Usage: $0 /mnt/point"
	exit 1
fi

mount -v --bind /dev "$MOUNTPOINT/dev"

mount -vt devpts devpts -o gid=5,mode=0620 "$MOUNTPOINT/dev/pts"
mount -vt proc proc "$MOUNTPOINT/proc"
mount -vt sysfs sysfs "$MOUNTPOINT/sys"
mount -vt tmpfs tmpfs "$MOUNTPOINT/run"

if [ -h "$MOUNTPOINT/dev/shm" ]; then
  install -v -d -m 1777 "$MOUNTPOINT$(realpath /dev/shm)"
else
  mount -vt tmpfs -o nosuid,nodev tmpfs "$MOUNTPOINT/dev/shm"
fi
