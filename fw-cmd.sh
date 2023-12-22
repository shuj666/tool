

#!/bin/bash

# 显示帮助信息
show_help() {
  echo "用法: $0 <add/remove/list> '<端口号>' [tcp/udp]"
  echo "  add/remove: 添加或移除防火墙规则"
  echo "  list: 显示防火墙规则"
  echo "  端口号: 单个或多个端口，若添加多个端口用引号括起来，例如 '80 443'"
  echo "  tcp/udp: 可选参数，指定协议，默认为tcp"
  echo ""
  echo "注意: 脚本只对防火墙规则 public 安全域生效。"
  echo ""
  echo "示例: $0 add '80 8080'"
  echo "      $0 remove '22 443' tcp"
  echo "      $0 list"
  exit 1
}

# 解析参数
action=$1
port=$2
protocol=${3:-tcp}  # 如果第三个参数未提供，默认为tcp

# 检查是否请求帮助
if [ "$action" == "--help" ] || [ "$action" == "-h" ]; then
  show_help
fi

# 检查参数合法性
if [ "$action" != "add" ] && [ "$action" != "remove" ] && [ "$action" != "list" ]; then
  echo "无效的操作参数。请使用 'add', 'remove' 或 'list'。"
  show_help
fi

# 执行相应操作
case $action in
  "add" | "remove")
    # 循环处理端口
    for current_port in $port; do
      sudo firewall-cmd --zone=public --$action-port=${current_port}/$protocol --permanent
    done
    ;;
  "list")
    sudo firewall-cmd --zone=public --list-all | grep '^  ports:'
    exit 0
    ;;
esac

# 重新加载防火墙规则
sudo firewall-cmd --reload

echo "防火墙规则已更新。"

