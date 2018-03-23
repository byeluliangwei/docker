# IMAGES REPOSITORY   reg.signit.cn:5000/third/ubuntu14.04-tomcat
# DESCRIPTION         安装Tomcat8环境
# VERSION             1.0.0

# 使用此ubuntu基础镜像开始构建
FROM reg.signit.cn:5000/base/ubuntu14.04-java8

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 安装Tomcat8
# 基础环境配置
ENV BASE_BIN                    /usr/local/bin
ENV CATALINA_VERSION            8.5.16
ENV CATALINA_NAME               apache-tomcat-${CATALINA_VERSION}
ENV CATALINA_HOME               ${BASE_BIN}/${CATALINA_NAME}
ENV CATALINA_HOME_ALIAS         /usr/tomcat
ENV SERVER_PORT                 8080
# 高级环境配置
ENV SERVER_PROTOCOL             Nio 
ENV SERVER_MAX_THREADS          4096
ENV SERVER_MIN_SPARE_THREADS    64
ENV SERVER_MAX_SPARE_THREADS    1024
ENV JVM_MIN_MEM                 32m
ENV JVM_MAX_MEM                 2048m
# 负载均衡配置
ENV SERVER_PROXY_SCHEME         http
ENV SERVER_PROXY_PORT           ""

RUN wget -c http://archive.apache.org/dist/tomcat/tomcat-8/v${CATALINA_VERSION}/bin/${CATALINA_NAME}.tar.gz && \
	tar -zxvf ${CATALINA_NAME}.tar.gz -C ${BASE_BIN} && \
	rm -f ${CATALINA_NAME}.tar.gz && \
	ln -s ${CATALINA_HOME} ${CATALINA_HOME_ALIAS}

# 修改context.xml
RUN sed -i '/<\/Context>/i <Resources cachingAllowed="true" cacheMaxSize="100000" \/>' ${CATALINA_HOME}/conf/context.xml 

# 设置JVM系统变量便于server.xml中引用
RUN sed -i '3i JAVA_OPTS="\$JAVA_OPTS -DSERVER_PORT=\${SERVER_PORT} -DSERVER_PROTOCOL=\${SERVER_PROTOCOL} -DSERVER_MAX_THREADS=\${SERVER_MAX_THREADS} -DSERVER_MIN_SPARE_THREADS=\${SERVER_MIN_SPARE_THREADS} -DSERVER_MAX_SPARE_THREADS=\${SERVER_MAX_SPARE_THREADS} -DSERVER_PROXY_PORT=\${SERVER_PROXY_PORT} -DSERVER_PROXY_SCHEME=\${SERVER_PROXY_SCHEME} " \nexport JAVA_OPTS' \
	${CATALINA_HOME}/bin/catalina.sh && \
	sed -i '3i JAVA_OPTS="\$JAVA_OPTS -XX:+UseParallelGC -Xms'${JVM_MIN_MEM}' -Xmx'${JVM_MAX_MEM}'" \nexport JAVA_OPTS' \
	${CATALINA_HOME}/bin/catalina.sh

# 设置server.xml的Connector值
RUN sed -i '1,/^    <Connector/s/^    <Connector.*/    <Connector port="\${SERVER_PORT}" \n\t proxyPort="\${SERVER_PROXY_PORT}" \n\t scheme="\${SERVER_PROXY_SCHEME}" \n\t executor="tomcatThreadPool" \n\t protocol="org.apache.coyote.http11.Http11\${SERVER_PROTOCOL}Protocol" \n\t maxThreads="\${SERVER_MAX_THREADS}" \n\t minSpareThreads="\${SERVER_MIN_SPARE_THREADS}" \n\t maxSpareThreads="\${SERVER_MAX_SPARE_THREADS}" \n\t debug="0" \n\t compression="on" \n\t compressionMinSize="2048" \n\t URIEncoding="UTF-8" \n\t useBodyEncodingForURI="true"/' \
	${CATALINA_HOME}/conf/server.xml  

WORKDIR ${CATALINA_HOME_ALIAS}

VOLUME [${CATALINA_HOME_ALIAS}/webapps/]