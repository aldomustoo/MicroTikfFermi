﻿#!/bin/bash

# Impostart la variabile 'IFNAME' con il nome dell'interfaccia alla quale è
# collegato il router
#
# Avviare questo script come root ed assicurarsi di aver installato il
# pacchetto 'dnsmasq'

IFNAME=eth0

ip addr replace 192.168.1.10/24 dev $IFNAME
ip link set dev $IFNAME up

dnsmasq --user=$(whoami) \
		--no-daemon \
		--listen-address 192.168.1.10 \
		--bind-interfaces \
		-p0 \
		--dhcp-authoritative \
		--dhcp-range=192.168.1.100,192.168.1.200 \
		--bootp-dynamic \
		--dhcp-boot=$(ls openwrt-*-initramfs-*) \
		--log-dhcp \
		--enable-tftp \
		--tftp-root=$(pwd)
