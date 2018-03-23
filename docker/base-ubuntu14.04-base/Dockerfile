# IMAGES REPOSITORY   reg.signit.cn:5000/base/ubuntu14.04-base
# DESCRIPTION         安装S6进程管理工具
# VERSION             1.0.0

# 使用此ubuntu基础镜像开始构建
FROM reg.signit.cn:5000/base/ubuntu14.04

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 添加s6-overlay进程管理工具
ENV S6_OVERLAY_VERSION          v1.19.1.1

# 安装s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
    rm -rf /tmp/*

ENTRYPOINT ["/init"]
CMD []