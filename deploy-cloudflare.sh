#!/bin/bash

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 显示彩色消息函数
echo_color() {
  echo -e "${2}${1}${NC}"
}

# 检查命令执行状态
check_status() {
  if [ $? -eq 0 ]; then
    echo_color "✅ $1成功" "${GREEN}"
  else
    echo_color "❌ $1失败，部署终止" "${RED}"
    exit 1
  fi
}

# 显示欢迎信息
echo_color "==========================================" "${BLUE}"
echo_color "   Next.js博客 Cloudflare Pages部署脚本   " "${BLUE}"
echo_color "==========================================" "${BLUE}"

# 获取当前目录
CURRENT_DIR=$(pwd)
REPO_DIR="/Users/pangjianfeng/CascadeProjects/Develop/pf-ai-bff"
BLOG_DIR="/Users/pangjianfeng/CascadeProjects/Develop/pf-ai-bff/nextjs-blog"
ENV_FILE="$BLOG_DIR/.env"

echo_color "📂 当前目录: $CURRENT_DIR" "${GREEN}"
echo_color "📂 项目目录: $REPO_DIR" "${GREEN}"

# 1. 构建项目
echo_color "1️⃣ 构建Next.js项目..." "${GREEN}"
cd "$BLOG_DIR"
npm run build
check_status "Next.js项目构建"

# 2. 从.env读取令牌（如果需要）
echo_color "2️⃣ 读取GitHub令牌..." "${GREEN}"

if [ -f "$ENV_FILE" ]; then
  # 安全地读取令牌
  TOKEN=$(grep GITHUB_TOKEN "$ENV_FILE" | cut -d '=' -f2 | sed 's/"//g')
  
  if [ -z "$TOKEN" ]; then
    echo_color "⚠️ 在.env文件中未找到GITHUB_TOKEN，将使用常规推送方式" "${YELLOW}"
  else
    echo_color "✅ 成功读取GitHub令牌" "${GREEN}"
  fi
else
  echo_color "⚠️ 找不到.env文件，将使用常规推送方式" "${YELLOW}"
fi

# 3. 切换到项目根目录
echo_color "3️⃣ 切换到项目根目录..." "${GREEN}"
cd "$REPO_DIR"
check_status "切换目录"

# 4. 添加所有改动的文件
echo_color "4️⃣ 添加所有改动文件..." "${GREEN}"
git add .
check_status "添加文件"

# 5. 获取提交信息
echo_color "5️⃣ 请输入提交信息 (默认: 'Update Next.js blog for Cloudflare Pages'):" "${YELLOW}"
read commit_message
if [ -z "$commit_message" ]; then
  commit_message="Update Next.js blog for Cloudflare Pages"
fi

# 6. 提交改动
echo_color "6️⃣ 提交改动: '$commit_message'" "${GREEN}"
git commit -m "$commit_message"
check_status "提交改动"

# 7. 使用令牌进行推送
echo_color "7️⃣ 推送到GitHub..." "${GREEN}"

if [ ! -z "$TOKEN" ]; then
  # 使用Git的凭证助手临时存储令牌
  echo_color "使用安全令牌推送..." "${GREEN}"
  git config --local credential.helper "!f() { echo username=RicardoPang; echo password=$TOKEN; }; f"
  
  # 推送
  git push origin main
  GIT_PUSH_RESULT=$?
  
  # 立即清除凭证助手
  git config --local --unset credential.helper
else
  # 常规推送
  echo_color "使用常规方式推送..." "${YELLOW}"
  git push origin main
  GIT_PUSH_RESULT=$?
fi

# 检查推送结果
if [ $GIT_PUSH_RESULT -eq 0 ]; then
  echo_color "✅ 推送到GitHub成功!" "${GREEN}"
else
  echo_color "❌ 推送到GitHub失败，部署终止" "${RED}"
  exit 1
fi

echo_color "==========================================" "${BLUE}"
echo_color "      🚀 代码已成功推送!                  " "${BLUE}"
echo_color "==========================================" "${BLUE}"
echo_color "💡 接下来步骤:" "${YELLOW}"
echo_color "1. 访问Cloudflare Pages控制台: https://dash.cloudflare.com/ac3283c45717d166d8c828bb3d93077c/workers-and-pages" "${YELLOW}"
echo_color "2. 连接您的GitHub仓库 (首次部署需要)" "${YELLOW}"
echo_color "3. 配置部署设置:" "${YELLOW}"
echo_color "   - 构建命令: npm run build" "${YELLOW}"
echo_color "   - 输出目录: .next" "${YELLOW}"
echo_color "   - 环境变量: 添加NEXT_PUBLIC_API_URL" "${YELLOW}"
echo_color "4. 部署完成后，配置zhulang.cloud子域名指向" "${YELLOW}"
