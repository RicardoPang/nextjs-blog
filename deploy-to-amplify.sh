#!/bin/bash

# 颜色设置
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
NC="\033[0m" # 恢复颜色

echo -e "${BLUE}=====================================${NC}"
echo -e "${GREEN}Next.js AWS Amplify 自动部署脚本${NC}"
echo -e "${BLUE}=====================================${NC}"

# 检查AWS CLI是否安装
if ! command -v aws &> /dev/null; then
    echo -e "${RED}错误: 未找到AWS CLI${NC}"
    echo -e "${YELLOW}请先安装AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html${NC}"
    exit 1
fi

# 检查是否已配置AWS凭证
if ! aws configure list &> /dev/null; then
    echo -e "${YELLOW}注意: 未找到AWS凭证配置${NC}"
    echo -e "请设置你的AWS凭证:"
    
    read -p "AWS访问密钥ID: " AWS_ACCESS_KEY_ID
    read -p "AWS秘密访问密钥: " AWS_SECRET_ACCESS_KEY
    read -p "默认区域名称 (例如 ap-northeast-1): " AWS_REGION
    
    # 设置AWS凭证
    aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
    aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
    aws configure set region "$AWS_REGION"
    aws configure set output json
    
    echo -e "${GREEN}AWS凭证已设置${NC}"
fi

# 项目目录
PROJECT_DIR="nextjs-blog"

# 删除旧目录（如果存在）
if [ -d "$PROJECT_DIR" ]; then
    echo -e "${YELLOW}发现已有项目目录，正在删除...${NC}"
    rm -rf "$PROJECT_DIR"
fi

# 克隆GitHub仓库
echo -e "${BLUE}正在克隆GitHub仓库...${NC}"
git clone https://github.com/RicardoPang/nextjs-blog.git

# 进入项目目录
cd "$PROJECT_DIR"

# 安装依赖
echo -e "${BLUE}正在安装依赖项...${NC}"
npm install

# 构建项目
echo -e "${BLUE}正在构建项目...${NC}"
npm run build

# 检查Amplify CLI是否安装
if ! command -v amplify &> /dev/null; then
    echo -e "${YELLOW}正在安装Amplify CLI...${NC}"
    npm install -g @aws-amplify/cli
fi

# 初始化Amplify项目
echo -e "${BLUE}正在初始化Amplify项目...${NC}"
amplify init --yes

# 添加托管配置
echo -e "${BLUE}正在添加托管配置...${NC}"
amplify add hosting

# 部署到Amplify
echo -e "${GREEN}正在部署到AWS Amplify...${NC}"
amplify publish --yes

echo -e "${BLUE}=====================================${NC}"
echo -e "${GREEN}部署完成!${NC}"
echo -e "${BLUE}=====================================${NC}"

# 输出应用URL
echo -e "你的应用已部署完成！"
echo -e "部署网址请查看上方Amplify输出信息"
