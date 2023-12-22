防火墙最多的操作就是开放端口，每次敲一长串命令。写个脚本偷懒。
./fw-cmd.sh -h
```
用法: ./fw-cmd.sh <add/remove/list> '<端口号>' [tcp/udp]
  add/remove: 添加或移除防火墙规则
  list: 显示防火墙规则
  端口号: 单个或多个端口，若添加多个端口用引号括起来，例如 '80 443'
  tcp/udp: 可选参数，指定协议，默认为tcp

注意: 脚本只对防火墙规则 public 安全域生效。

示例: ./fw-cmd.sh add '80 8080'
      ./fw-cmd.sh remove '22 443' tcp
      ./fw-cmd.sh list

```
