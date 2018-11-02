# IMAGES REPOSITORY   reg.signit.cn:5000/base/alpine-java7
# DESCRIPTION         安装OpenJDK7环境
# VERSION             1.0.0

# 使用此alpine基础镜像开始构建
FROM reg.signit.cn:5000/base/alpine-base 

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

ENV JAVA_VERSION=8u92 \
    JAVA_ALPINE_VERSION=8.131.11-r1 \
    JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk \
    PATH=$PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

# 添加自动检测JDK或JRE安装的JAVA_HOME目录的脚本
RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home && \
    chmod +x /usr/local/bin/docker-java-home

# 执行Java运行环境的安装
RUN set -x \
    apk upgrade --update && \
    apk add --no-cache openjdk8="$JAVA_ALPINE_VERSION" && \
    [ "$JAVA_HOME" = "$(docker-java-home)" ]