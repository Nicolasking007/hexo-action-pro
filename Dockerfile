FROM node:18.15.0-buster-slim

LABEL version="1.0.1"
LABEL repository="https://github.com/Nicolasking007/hexo-action-pro"
LABEL homepage="https://Nicolasking007.github.io"
LABEL maintainer="Nicolasking007 <nicolas-king@qq.com>"

LABEL "com.github.actions.name"="Hexo Action pro"
LABEL "com.github.actions.description"="Hexo CI/CD action for automating deployment."
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="green"

COPY README.md LICENSE entrypoint.sh /
COPY sync_deploy_history.js /sync_deploy_history.js

RUN apt-get update > /dev/null && \
    apt-get install -y git openssh-client > /dev/null ; \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]