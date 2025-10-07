#!/bin/bash
set -x

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

DISK="$1"
MOUNTPOINT="$2"

if [ -z "$DISK" ] || [ -z "$MOUNTPOINT" ]; then
	echo "Usage: $0 /dev/sdX /mnt/point"
	exit 1
fi

mkdir -p "$MOUNTPOINT"
mount -v -t ext4 "${DISK}4" "$MOUNTPOINT"
mkdir "$MOUNTPOINT/boot"
mount -v -t ext4 "${DISK}2" "$MOUNTPOINT/boot"
swapon -v "${DISK}3"
