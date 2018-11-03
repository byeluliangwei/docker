# IMAGES REPOSITORY   registry.cn-hangzhou.aliyuncs.com/luliangwei/alpine:s6-overlay
# DESCRIPTION         安装S6进程管理工具
# VERSION             1.0.0

# 使用此alpine基础镜像开始构建
FROM registry.cn-hangzhou.aliyuncs.com/luliangwei/alpine:base

# 指定镜像创建者和联系方式
MAINTAINER luliangwei luliangwei1874@163.com

# 添加s6-overlay进程管理工具
ENV S6_OVERLAY_VERSION 			v1.19.1.1

RUN apk add --update --no-cache bind-tools curl libcap && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz \
    | tar xfz - -C / && \
    apk del curl

COPY root /

ENTRYPOINT ["/init"]
CMD []
