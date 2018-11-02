# IMAGES REPOSITORY   reg.signit.cn:5000/signit/wesign-mss-config
# DESCRIPTION         安装signit-wesign-mss相关微服务环境
# VERSION             1.0.0

# 使用此alpine基础镜像开始构建
FROM reg.signit.cn:5000/signit/wesign-mss-config-base

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 环境变量定义
ENV SERVER_SERVICE 				signit-wesign-mss-config
ENV SERVER_VERSION 				1.0.0-SNAPSHOT 
ENV SERVER_PROFILE 				dev
ENV SERVER_REPOS 				public-snapshots 
ENV SERVER_CONTEXT 				/ 
ENV SERVER_TYPE 				jar 
ENV SERVER_PORT					6184
ENV SERVER_ROOT_HOME 			/usr/local/bin/${SERVER_SERVICE} 
ENV SERVER_BIN 					${SERVER_ROOT_HOME}/${SERVER_SERVICE}.${SERVER_TYPE} 
ENV HOSTS_VERSION 				latest

# 添加独立的外部文件
ADD ../run /etc/services.d/${SERVER_SERVICE}/

# 安装微服务 - signit-wesign-mss-config
RUN chmod +x /etc/services.d/${SERVER_SERVICE}/run && \
    mkdir -p ${SERVER_ROOT_HOME} && \
    cd ${SERVER_ROOT_HOME}
# 添加服务部署相关的外部文件
ADD http://mvn.ns.me/nexus/service/local/repositories/signit-releases/content/cn/signit/public/hosts/${SERVER_PROFILE}-mode/${HOSTS_VERSION}/${SERVER_PROFILE}-mode-${HOSTS_VERSION}.hosts /tmp/hosts
ADD http://mvn.ns.me/nexus/service/local/artifact/maven/content?r=${SERVER_REPOS}&g=cn.signit&a=${SERVER_SERVICE}&v=${SERVER_VERSION}&e=${SERVER_TYPE} ${SERVER_BIN}

# 需要暴露的端口    
EXPOSE ${SERVER_PORT}