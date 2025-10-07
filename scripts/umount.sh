#!/bin/bash
set -x

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

DISK="$1"

if [ -z "$DISK" ]; then
	echo "Usage: $0 /dev/sdX"
	exit 1
fi

umount "${DISK}2"
umount "${DISK}4"
swapoff "${DISK}3"
