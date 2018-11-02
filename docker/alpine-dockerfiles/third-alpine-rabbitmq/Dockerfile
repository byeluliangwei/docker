#ENVIRONMENT RabbitMQ3.5
#
#VERSION 1.0.0

# 使用此ubuntu基础镜像开始构建
FROM 114.215.149.118:5000/signit/cloudsign-ubuntu-14.04

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 添加开机启动脚本文件
ADD rabbitmq-start /usr/local/bin

# 安装RabbitMQ
RUN echo 'deb http://www.rabbitmq.com/debian/ testing main' | tee /etc/apt/sources.list.d/rabbitmq.list && \
	wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | apt-key add - && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
	rm -rf /var/lib/apt/lists/* && \
	rabbitmq-plugins enable rabbitmq_management && \
	rabbitmq-plugins enable rabbitmq_stomp && \
	echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config && \
	chmod +x /usr/local/bin/rabbitmq-start

# 定义容器内环境变量
ENV RABBITMQ_LOG_BASE /data/rabbitmq/log
ENV RABBITMQ_MNESIA_BASE /data/rabbitmq/mnesia

# 定义挂载点(便于数据的持续保存,容器之间互相访问目录)
VOLUME ["/data/rabbitmq/log", "/data/rabbitmq/mnesia"]

# 定义工作目录
WORKDIR /data/rabbitmq

# 暴露宿主机端口
EXPOSE 5672 15672 61613

# 启动容器时默认执行启动命令 
ENTRYPOINT ["rabbitmq-start"]
