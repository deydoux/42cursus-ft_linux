#!/bin/bash
set -x

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

DISK="$1"
MOUNTPOINT="$2"
DEST="$3"

if [ -z "$DISK" ] || [ -z "$MOUNTPOINT" ] || [ -z "$DEST" ]; then
	echo "Usage: $0 /dev/sdX /mnt/point "'$HOME/backup.tar.xz'
	exit 1
fi

mountpoint -q "$MOUNTPOINT/dev/shm" && umount "$MOUNTPOINT/dev/shm"
umount "$MOUNTPOINT/dev/pts"
umount "$MOUNTPOINT/sys"
umount "$MOUNTPOINT/proc"
umount "$MOUNTPOINT/run"
umount "$MOUNTPOINT/dev"

cd "$MOUNTPOINT"
tar -cJpf "$DEST" .
