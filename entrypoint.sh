#!/bin/sh

set -e

# 设置 SSH 私钥
mkdir -p /root/.ssh/
echo "$INPUT_DEPLOY_KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts

# 设置部署 Git 账户信息
git config --global user.name "$INPUT_USER_NAME"
git config --global user.email "$INPUT_USER_EMAIL"

# 安装 Hexo 环境
echo ">_ Install NPM dependencies ..."
npm install -g hexo-cli
npm install


echo ">_ Clean cache files ..."
cd $GITHUB_WORKSPACE  # 切换到工作目录
npx hexo clean


# 部署
if [ "$INPUT_COMMIT_MSG" = "none" ]; then
    # 避免 hexo-butterfly-douban 构建冲突，使用 hexo g -deploy
    hexo g -deploy
elif [ "$INPUT_COMMIT_MSG" = "" ] || [ "$INPUT_COMMIT_MSG" = "default" ]; then
    # 拉取原始发布仓库
    NODE_PATH=$NODE_PATH:$(pwd)/node_modules node /sync_deploy_history.js
    hexo g -deploy
else
    # 指定提交消息
    NODE_PATH=$NODE_PATH:$(pwd)/node_modules node /sync_deploy_history.js
    hexo g -deploy -m "$INPUT_COMMIT_MSG"
fi

echo ::set-output name=notify::"Deploy complate."
