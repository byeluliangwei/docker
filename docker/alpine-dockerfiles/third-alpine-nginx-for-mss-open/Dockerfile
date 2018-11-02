# IMAGES REPOSITORY   reg.signit.cn:5000/third/alpine-nginx-for-mss-open
# DESCRIPTION         安装wesign-mss-open的nginx SSL环境
# VERSION             1.0.0

# 使用此alpine基础镜像开始构建
FROM reg.signit.cn:5000/third/alpine-nginx

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 添加相关配置文件
ADD ./etc /etc
    
# 默认暴露80和443端口
EXPOSE 80 443