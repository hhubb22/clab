#!/bin/sh
# 当任何命令失败时立即退出脚本
set -e

# --- 第一步：配置 eth1 的 IP 地址 ---
INTERFACE="eth1"
IP_ADDR="192.168.1.1/24"
CONFIG_FILE="/etc/kea/kea-dhcp4.conf"

echo "Waiting for interface ${INTERFACE} to be ready..."
# (可选但推荐) 添加一个简单的等待循环，确保接口确实存在
while ! ip link show ${INTERFACE} > /dev/null 2>&1; do
  echo "Interface ${INTERFACE} not found, waiting..."
  sleep 1
done

echo "Interface ${INTERFACE} found. Configuring IP address ${IP_ADDR}..."
ip addr add ${IP_ADDR} dev ${INTERFACE}
echo "IP address configured on ${INTERFACE}."

# --- 第二步：启动 Kea DHCP 服务器 ---
echo "Starting Kea DHCPv4 server with config ${CONFIG_FILE}..."
# 使用 shell 的 'exec' 命令来启动 kea-dhcp4。
# 这会用 kea-dhcp4 进程替换当前的 shell 进程。
# 这样做的好处是 kea-dhcp4 会成为容器的主进程 (PID 1，如果脚本是作为 PID 1 启动的话)，
# 并且容器的生命周期会直接与 kea-dhcp4 进程绑定。
exec kea-dhcp4 -c ${CONFIG_FILE}

# exec 之后的任何内容都不会被执行，因为进程已经被替换了
echo "Kea server started." # 这行实际不会执行