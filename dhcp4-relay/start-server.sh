#!/bin/sh
# Exit immediately if a command exits with a non-zero status.
set -e

INTERFACE="eth1"
IP_ADDR="192.168.2.1/24"
CONFIG_FILE="/etc/kea/kea-dhcp4.conf" # Path inside container matches binds

echo "Server: Waiting for interface ${INTERFACE}..."
while ! ip link show ${INTERFACE} > /dev/null 2>&1; do sleep 1; done
echo "Server: Configuring ${INTERFACE} with ${IP_ADDR}..."
ip addr add ${IP_ADDR} dev ${INTERFACE}

echo "Server: Starting Kea DHCPv4 Server using ${CONFIG_FILE}..."
# Use shell's 'exec' to replace this script process with kea-dhcp4
exec kea-dhcp4 -c ${CONFIG_FILE}

# Code below exec is not reachable
echo "Server: Kea started."