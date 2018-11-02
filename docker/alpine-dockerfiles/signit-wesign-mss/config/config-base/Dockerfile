# IMAGES REPOSITORY   reg.signit.cn:5000/signit/wesign-mss-config-base
# DESCRIPTION         安装Java/SVN环境
# VERSION             1.0.0

# 使用此alpine基础镜像开始构建
FROM reg.signit.cn:5000/base/alpine-java8

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# Proxy settings if necessary
# ENV http_proxy=http://proxy:8080
# ENV https_proxy=http://proxy:8080
# ENV no_proxy="127.0.0.1,localhost,.mydomain.com"

# 安装和配置 Apache WebDAV 和 Subversion
RUN apk --no-cache add apache2 apache2-utils apache2-webdav mod_dav_svn subversion
ADD vh-davsvn.conf /etc/apache2/conf.d/
RUN mkdir -p /run/apache2

ADD run /etc/services.d/svn/run
RUN chmod +x /etc/services.d/svn/run
EXPOSE 80

VOLUME ["/var/svn"]