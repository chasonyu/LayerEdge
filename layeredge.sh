#!/bin/bash

# 拉取仓库
echo "正在拉取仓库..."
git clone https://github.com/sdohuajia/LayerEdge.git

# 进入目录
echo "进入项目目录..."
cd LayerEdge

# 让用户输入代理地址
echo "请输入代理地址（格式如 http://代理账号:代理密码@127.0.0.1:8080），每次输入一个，直接按回车结束输入："
> proxy.txt  # 清空或创建 proxy.txt 文件
while true; do
  read -p "代理地址（回车结束）：" proxy
  if [ -z "$proxy" ]; then
    break  # 如果用户直接按回车，结束输入
  fi
  echo "$proxy" >> proxy.txt  # 将代理地址写入 proxy.txt
done

# 检查 wallets.txt 是否存在，如果不存在则创建并让用户输入钱包
if [ ! -f "wallets.txt" ]; then
  echo "未找到 wallets.txt 文件，正在创建..."
  > wallets.txt  # 创建空文件

  echo "请输入钱包地址和私钥，格式为：钱包地址,私钥"
  echo "每次输入一个钱包，直接按回车结束输入："
  while true; do
    read -p "钱包地址,私钥（回车结束）：" wallet
    if [ -z "$wallet" ]; then
      break  # 如果用户直接按回车，结束输入
    fi
    echo "$wallet" >> wallets.txt  # 将钱包信息写入 wallets.txt
  done
else
  echo "已找到 wallets.txt 文件，跳过钱包输入。"
fi

# 安装依赖
echo "正在使用 npm 安装依赖..."
npm install

# 提示用户操作完成
echo "操作完成！代理已保存到 proxy.txt，钱包已保存到 wallets.txt，依赖已安装。"

# 启动项目
echo "正在启动项目..."
npm start
