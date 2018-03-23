# IMAGES REPOSITORY   reg.signit.cn:5000/base/ubuntu14.04
# DESCRIPTION         基于最新版ubuntu14.04并设置了系统编码和时区
# VERSION             1.0.0

# 使用此ubuntu基础镜像开始构建
FROM ubuntu:14.04 

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

#指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 编码问题
ENV LANG            zh_CN.UTF-8  
ENV LANGUAGE        zh_CN:zh  
ENV LC_ALL          zh_CN.UTF-8  

RUN locale-gen zh_CN.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \
    locale-gen zh_CN.UTF-8  

# 时区问题
ENV TZ Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone