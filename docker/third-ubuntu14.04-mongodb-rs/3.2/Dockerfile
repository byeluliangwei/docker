# IMAGES REPOSITORY   reg.signit.cn:5000/third/ubuntu14.04-mongodb-rs
# DESCRIPTION         安装MongoDB3.2数据库
# VERSION             1.0.0

FROM reg.signit.cn:5000/base/ubuntu14.04-base

#指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# reuqired
ENV MONGO_VER            3.2
ENV DB_CONF              /root/.db_conf
ENV REPL_SET             signit_mongo_cluster
ENV REPL_SET_ID          1
ENV REPL_SET_HOST        mongodb-rs.ns.me
ENV REPL_SET_PORT        27017
ENV AUTH                 yes
ENV KEY_FILE             ${DB_CONF}/mongodb-keyfile
# options
ENV BIND_IP              0.0.0.0
ENV DB_PATH              /data/mongodb
ENV STORAGE_ENGINE       wiredTiger
ENV JOURNALING           yes
ENV MONGODB_ROOT_NAME    root
ENV MONGODB_ROOT_PASS    @signit@root&$Key?ok!
ENV MONGODB_WORK_NAME    rsworker
ENV MONGODB_WORK_PASS    @signit@rsworker$&Key!
ENV MONGODB_WORK_DB      SignItFileAndServiceDB
ENV OPLOG_SIZE           51200
# customize
ENV AS_PRIMARY           yes 

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/"${MONGO_VER}" multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list && \
    apt-get update && \
    apt-get install -y bash openssl && \
    apt-get install -y pwgen mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools && \
    echo "mongodb-org hold" | dpkg --set-selections && echo "mongodb-org-server hold" | dpkg --set-selections && \
    echo "mongodb-org-shell hold" | dpkg --set-selections && \
    echo "mongodb-org-mongos hold" | dpkg --set-selections && \
    echo "mongodb-org-tools hold" | dpkg --set-selections && \
    mkdir -p ${DB_CONF}

# 添加独立的外部文件
ADD ./run /etc/services.d/${REPL_SET}/
RUN chmod +x /etc/services.d/${REPL_SET}/run

ADD run.sh ${DB_CONF}/run.sh
RUN chmod +x ${DB_CONF}/run.sh

# 初始化Replica Set的脚本
ADD set_mongodb_rs.sh ${DB_CONF}/set_mongodb_rs.sh
RUN chmod +x ${DB_CONF}/set_mongodb_rs.sh

# 初始化用户密码的脚本
ADD set_mongodb_password.sh ${DB_CONF}/set_mongodb_password.sh
RUN chmod +x ${DB_CONF}/set_mongodb_password.sh

# 初始化REPLICA SET的keyfile文件
# keyfile生成命令: openssl rand -base64 741 > mongodb-keyfile && chmod 600 mongodb-keyfile
ADD mongodb-keyfile ${KEY_FILE}
RUN chmod 600 ${KEY_FILE}

# ENV MONGO1 "172.25.0.10"
# ENV MONGO2 "172.25.0.11"
# ENV MONGO3 "172.25.0.12"
# mongo $MONGO1 --eval "rs.initiate(); myconf = rs.conf(); myconf.members[0].host = '$MONGO1'; rs.reconfig(myconf,{force:true}); rs.add('$MONGO2'); rs.add('$MONGO3');"


EXPOSE 27017 28017 27018 28018 27019 28019