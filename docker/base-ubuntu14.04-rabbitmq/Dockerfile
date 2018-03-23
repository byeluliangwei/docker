# IMAGES REPOSITORY   reg.signit.cn:5000/third/ubuntu14.04-rabbitmq
# DESCRIPTION         安装RabbitMQ环境
# VERSION             1.0.0

# 使用此ubuntu基础镜像开始构建
FROM reg.signit.cn:5000/base/ubuntu14.04-base

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 声明系统环境变量
ENV RABBITMQ                               rabbitmq
ENV RABBITMQ_VERSION                       3.7
ENV RABBIT_PLUGINS_HOME                    /usr/lib/rabbitmq/lib/rabbitmq_server-${RABBITMQ_VERSION}.*/plugins

# 添加开机启动脚本文件
ADD rabbitmq-start /usr/local/bin

# 安装ERLANG环境
RUN apt-get update && \ 
    apt-get -y install wget apt-transport-https unzip && \ 
    wget -c -O- http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add - && \
    echo "deb http://packages.erlang-solutions.com/ubuntu trusty contrib" | sudo tee -a /etc/apt/sources.list.d/erlang_solutions.list > /dev/null && \
    sudo apt-get update && \
    sudo apt-get install -y --force-yes esl-erlang

# 安装RabbitMQ
RUN echo "deb https://dl.bintray.com/rabbitmq/debian trusty main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list && \
    wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | sudo apt-key add - && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
    rm -rf /var/lib/apt/lists/* && \
    cd ${RABBIT_PLUGINS_HOME} && \
    wget https://dl.bintray.com/rabbitmq/community-plugins/${RABBITMQ_VERSION}.x/rabbitmq_delayed_message_exchange/rabbitmq_delayed_message_exchange-20171201-3.7.x.zip -O rabbitmq_delayed_message_exchange.zip && \
    unzip rabbitmq_delayed_message_exchange.zip && \
    rm -f rabbitmq_delayed_message_exchange.zip && \
    rabbitmq-plugins enable rabbitmq_management && \
    rabbitmq-plugins enable rabbitmq_stomp && \
    rabbitmq-plugins enable rabbitmq_delayed_message_exchange && \
    echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config && \
    chmod +x /usr/local/bin/rabbitmq-start

# 定义容器内环境变量
ENV RABBITMQ_LOG_BASE /data/rabbitmq/log
ENV RABBITMQ_MNESIA_BASE /data/rabbitmq/mnesia

# 添加独立的外部文件
ADD ./run /etc/services.d/${RABBITMQ}/
RUN chmod +x /etc/services.d/${RABBITMQ}/run

# 定义挂载点(便于数据的持续保存,容器之间互相访问目录)
VOLUME ["/data/rabbitmq/log", "/data/rabbitmq/mnesia"]

# 定义工作目录
WORKDIR /data/rabbitmq

# 暴露宿主机端口
EXPOSE 5672 15672 61613