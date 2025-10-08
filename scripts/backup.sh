#!/bin/bash
set -x

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

MOUNTPOINT="$1"
DEST="$2"

if [ -z "$MOUNTPOINT" ] || [ -z "$DEST" ]; then
	echo "Usage: $0 /mnt/point "'$HOME/backup.tar.xz'
	exit 1
fi

DEST="$(realpath "$DEST")"

./umount_virtfs.sh "$MOUNTPOINT"

cd "$MOUNTPOINT"
tar -cJpf "$DEST" .
