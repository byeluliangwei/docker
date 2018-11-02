# ENVIRONMENT 
#
# DATE_TIME 2017年6月5日-17时44分48秒
#
# VERSION 1.0.0

# 使用此alpine基础镜像开始构建
FROM registry:2 

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 添加外部配置 
# 参考: http://www.cnblogs.com/sparkdev/p/6890995.html
# 申请自签名证书：
# openssl req -newkey rsa:4096 -nodes -sha256 -keyout dcerts/118.190.87.51.key -x509 -days 3560 -out dcerts/118.190.87.51.crt
COPY tls-certs /certs/
# 生成认证的用户名（signit）密码（reg@signit.cn）：
# docker run --rm --entrypoint htpasswd registry:2 -Bbn <username> "<password>" > ./htpasswd
COPY htpasswd /httpasswd_storage/

# 添加SSL支持
ENV TLS_NET_MODE WAN
ENV TLS_CERT_NAME 118.190.87.51
ENV REGISTRY_HTTP_TLS_CERTIFICATE /certs/${TLS_NET_MODE}/${TLS_CERT_NAME}.crt
ENV REGISTRY_HTTP_TLS_KEY /certs/${TLS_NET_MODE}/${TLS_CERT_NAME}.key
ENV EGISTRY_STORAGE_DELETE_ENABLED true
ENV REGISTRY_AUTH htpasswd
ENV REGISTRY_AUTH_HTPASSWD_REALM Registry Realm
ENV REGISTRY_AUTH_HTPASSWD_PATH /httpasswd_storage/htpasswd

# 挂载目录
VOLUME ["/var/lib/registry"] 

# 需要暴露端口
EXPOSE 5000