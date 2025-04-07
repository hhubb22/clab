# DHCP4 Relay - ContainerLab 测试环境

这是一个使用ContainerLab搭建的DHCPv4中继测试环境，包含Kea DHCP服务器、中继代理和测试客户端。

## 网络拓扑

- 1个DHCP客户端容器(client)
- 1个DHCP中继容器(relay)
- 1个DHCP服务器容器(server)

```
client <---> relay <---> server
```

## 快速开始

1. 确保已安装ContainerLab
2. 在项目目录下运行:
   ```bash
   clab deploy -t dhcp4-relay.clab.yaml
   ```
3. 查看DHCP服务器日志:
   ```bash
   docker logs -f server
   ```
4. 查看DHCP中继日志:
   ```bash
   docker logs -f relay
   ```
5. 测试客户端获取IP:
   ```bash
   docker exec -it client dhclient -v eth1
   ```

## DHCP服务器配置

- 接口: eth1 (192.168.2.1/24)
- 子网: 192.168.1.0/24
- IP地址池: 192.168.1.100 - 192.168.1.200
- 默认网关: 192.168.1.254
- DNS服务器: 8.8.8.8, 1.1.1.1
- 租约时间: 3600秒 (1小时)

## 中继配置

- 客户端侧接口: eth1 (192.168.1.1/24)
- 服务器侧接口: eth2 (192.168.2.2/24)
- 中继目标服务器: 192.168.2.1

## 文件说明

- `dhcp4-relay.clab.yaml`: ContainerLab拓扑定义文件
- `start-server.sh`: DHCP服务器启动脚本
- `start-relay.sh`: DHCP中继启动脚本
- `server-kea-dhcp4.conf`: Kea DHCP服务器配置文件

## 清理环境

```bash
clab destroy -t dhcp4-relay.clab.yaml
