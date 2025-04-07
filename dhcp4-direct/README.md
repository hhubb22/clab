# DHCP4 Direct - ContainerLab 测试环境

这是一个使用ContainerLab搭建的DHCPv4测试环境，包含Kea DHCP服务器和测试客户端。

## 网络拓扑

- 1个OVS交换机(switch1)
- 1个DHCP服务器容器(dhcp_server)
- 1个DHCP客户端容器(client1)

```
client1 <---> switch1 <---> dhcp_server
```

## 先决条件

- 安装Open vSwitch (OVS)
- 创建OVS网桥: 
  ```bash
  sudo ovs-vsctl add-br switch1
  ```

## 快速开始

1. 确保已安装ContainerLab
2. 在项目目录下运行:
   ```bash
   clab deploy -t dhcp-direct.clab.yaml
   ```
3. 查看DHCP服务器日志:
   ```bash
   docker logs -f dhcp_server
   ```
4. 测试客户端获取IP:
   ```bash
   docker exec -it client1 dhclient -v eth1
   ```

## DHCP服务器配置

- 接口: eth1 (192.168.1.1/24)
- 子网: 192.168.1.0/24
- IP地址池: 192.168.1.100 - 192.168.1.200
- 默认网关: 192.168.1.1
- DNS服务器: 8.8.8.8, 1.1.1.1
- 域名: mylab.local
- 租约时间: 4000秒 (~66分钟)

## 文件说明

- `dhcp-direct.clab.yaml`: ContainerLab拓扑定义文件
- `start-dhcp-server.sh`: DHCP服务器启动脚本
- `server-config/kea-dhcp4.conf`: Kea DHCP服务器配置文件

## 清理环境

```bash
clab destroy -t dhcp-direct.clab.yaml
