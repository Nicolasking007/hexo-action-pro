FROM node:18.15.0-buster-slim

LABEL version="1.0.0"
LABEL repository="https://github.com/Nicolasking007/hexo-action-pro"
LABEL homepage="https://Nicolasking007.github.io"
LABEL maintainer="Nicolasking007 <nicolas-king@qq.com>"

COPY entrypoint.sh /entrypoint.sh
COPY sync_deploy_history.js /sync_deploy_history.js

RUN apt-get update > /dev/null && \
    apt-get install -y git openssh-client > /dev/null ; \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]