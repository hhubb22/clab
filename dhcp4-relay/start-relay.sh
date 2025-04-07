#!/bin/sh
# Exit immediately if a command exits with a non-zero status.
set -e

INTERFACE1="eth1"
INTERFACE2="eth2"
IP_ADDR1="192.168.1.1/24"
IP_ADDR2="192.168.2.2/24"
DHCP_SERVER="192.168.2.1"  # 替换为您的DHCP服务器IP

echo "Relay: Waiting for interfaces ${INTERFACE1} and ${INTERFACE2}..."
while ! ip link show ${INTERFACE1} > /dev/null 2>&1 || ! ip link show ${INTERFACE2} > /dev/null 2>&1; do
    sleep 1
done

echo "Relay: Configuring ${INTERFACE1} with ${IP_ADDR1}..."
ip addr add ${IP_ADDR1} dev ${INTERFACE1}

echo "Relay: Configuring ${INTERFACE2} with ${IP_ADDR2}..."
ip addr add ${IP_ADDR2} dev ${INTERFACE2}

echo "Relay: Starting DHCP Relay between ${INTERFACE1} and ${INTERFACE2}..."
# 使用exec替换当前进程
exec dhcrelay -d -i ${INTERFACE1} -i ${INTERFACE2} ${DHCP_SERVER}

# 下面的代码不会被执行
echo "Relay: DHCP Relay started."