#!/bin/bash
set -x

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

DISK="$1"
MOUNTPOINT="$2"
SRC="$3"

if [ -z "$DISK" ] || [ -z "$MOUNTPOINT" ] || [ -z "$SRC" ]; then
	echo "Usage: $0 /dev/sdX /mnt/point "'$HOME/backup.tar.xz'
	exit 1
fi

cd "$MOUNTPOINT"
rm -rf ./*
tar -xpf "$SRC"
