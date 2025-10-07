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

read -p "This will erase all data on $DISK. Are you sure? (y/N) " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
	echo "Aborting."
	exit
fi

parted "$DISK" --script \
	mklabel gpt \
	mkpart primary 1MiB 2MiB \
	set 1 bios_grub on \
	mkpart primary ext4 2MiB 202MiB \
	mkpart primary linux-swap 202MiB 2250MiB \
	mkpart primary ext4 2250MiB 100%

mkfs -v -t ext4 "${DISK}2"
mkswap -v "${DISK}3"
mkfs -v -t ext4 "${DISK}4"
