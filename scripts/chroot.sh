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

chroot "$MOUNTPOINT" /usr/bin/env -i \
	HOME=/root \
	TERM="$TERM" \
	PS1='(lfs chroot) \u:\w\$ ' \
	PATH=/usr/bin:/usr/sbin \
	MAKEFLAGS="-j$(nproc)" \
	TESTSUITEFLAGS="-j$(nproc)" \
	/bin/bash --login
