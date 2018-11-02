# IMAGES REPOSITORY   reg.signit.cn:5000/third/alpine-nginx
# DESCRIPTION         安装nginx环境
# VERSION             1.0.0

# 使用此alpine基础镜像开始构建
FROM reg.signit.cn:5000/base/alpine-base 

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 声明系统变量
ENV NGINX_VERSION 				1.12.0-r2
ENV NGINX_DEFAULT_ROOT 			/usr/local/www

# 添加相关配置文件
ADD root /

# 安装 nginx
RUN chmod -R +x /etc/services.d/nginx && \
    apk add --update nginx=${NGINX_VERSION} && \
    rm -rf /var/cache/apk/* && \
    chown -R nginx:www-data /var/lib/nginx && \ 
    sed -i \ 
    's/.*<\/body>/<p><em>Nginx'${NGINX_VERSION}' for <a href="https:\/\/signit.cn">signit.cn<\/a>\.<\/em><\/p>\n<\/body>/' \
    ${NGINX_DEFAULT_ROOT}/index.html
    
# 默认暴露80和443端口
EXPOSE 80 443