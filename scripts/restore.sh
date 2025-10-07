#!/bin/bash
set -x

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

MOUNTPOINT="$1"
SRC="$2"

if [ -z "$MOUNTPOINT" ] || [ -z "$SRC" ]; then
	echo "Usage: $0 /mnt/point "'$HOME/backup.tar.xz'
	exit 1
fi

cd "$MOUNTPOINT"
rm -rf ./*
tar -xpf "$SRC"
