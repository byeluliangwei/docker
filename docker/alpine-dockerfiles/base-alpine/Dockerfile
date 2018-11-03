# IMAGES REPOSITORY   registry.cn-hangzhou.aliyuncs.com/luliangwei/alpine:base
# DESCRIPTION         基于最新版alpine并设置了系统编码和时区
# VERSION             1.0.0

# 使用此alpine基础镜像开始构建
FROM alpine

# 指定镜像创建者和联系方式
MAINTAINER luliangwei luliangwei1874@163.com

# 编码问题
ENV LANG            zh_CN.UTF-8
ENV LANGUAGE        zh_CN:zh
ENV LC_ALL          zh_CN.UTF-8

# 时区问题
RUN apk update && apk add ca-certificates && \
    apk add tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
