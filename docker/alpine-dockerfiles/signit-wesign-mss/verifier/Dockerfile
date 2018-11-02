# ENVIRONMENT signit-wesign-mss相关微服务
#
# DATE_TIME 2017年6月7日-20时16分00秒
#
# VERSION 1.0.0

# 使用此alpine基础镜像开始构建
FROM reg.signit.cn:5000/base/alpine-java8 

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 环境变量定义
ENV SERVER_SERVICE 				cloudsign-server-verifier 
ENV SERVER_VERSION 				0.0.1-SNAPSHOT 
ENV SERVER_PROFILE 				develop 
ENV SERVER_REPOS 				public-snapshots 
ENV SERVER_CONTEXT 				/ 
ENV SERVER_TYPE 				jar 
ENV SERVER_ROOT_HOME 			/usr/local/bin/${SERVER_SERVICE} 
ENV SERVER_BIN 					${SERVER_ROOT_HOME}/${SERVER_SERVICE}.${SERVER_TYPE} 
ENV HOSTS_VERSION 				1.0.0

# 添加独立的外部文件
ADD ../run /etc/services.d/${SERVER_SERVICE}/

# 安装微服务 - signit-wesign-mss-verifier  
RUN chmod +x /etc/services.d/${SERVER_SERVICE}/run && \
    mkdir -p ${SERVER_ROOT_HOME} && \
    cd ${SERVER_ROOT_HOME}
# 添加服务部署相关的外部文件
ADD http://mvn.ns.me/nexus/service/local/repositories/signit-releases/content/cn/signit/public/hosts/${SERVER_PROFILE}-mode/${HOSTS_VERSION}/${SERVER_PROFILE}-mode-${HOSTS_VERSION}.hosts /tmp/hosts
ADD http://mvn.ns.me/nexus/service/local/artifact/maven/content?r=${SERVER_REPOS}&g=cn.signit&a=${SERVER_SERVICE}&v=${SERVER_VERSION}&e=${SERVER_TYPE} ${SERVER_BIN}

WORKDIR ${CATALINA_HOME}

# 需要暴露的端口    
EXPOSE 8003