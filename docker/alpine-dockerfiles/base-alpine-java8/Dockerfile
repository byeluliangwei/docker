# IMAGES REPOSITORY   registry.cn-hangzhou.aliyuncs.com/luliangwei/alpine:java8
# DESCRIPTION         安装OpenJDK8环境
# VERSION             1.0.0

# 使用此alpine基础镜像开始构建
FROM registry.cn-hangzhou.aliyuncs.com/luliangwei/alpine:s6-overlay

# 指定镜像创建者和联系方式
MAINTAINER luliangwei luliangwei1874@163.com

ENV JAVA_VERSION=8u131 \
    JAVA_ALPINE_VERSION=8.181.13-r0 \
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

# 解除JCE安全限制
RUN apk upgrade --update && \
    apk add --update curl unzip && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/unlimited_jce_policy.zip "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip" && \
    unzip -jo -d ${JAVA_HOME}/jre/lib/security /tmp/unlimited_jce_policy.zip && \
    apk del curl unzip && \
    rm -rf /tmp/* /var/cache/apk/*
