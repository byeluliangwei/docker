#ENVIRONMENT MongoDB replication set mode
#
#VERSION 1.0.0

#使用此ubuntu基础镜像开始构建
FROM 114.215.149.118:5000/signit/cloudsign-ubuntu-14.04

#指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

ENV DB_CONF /root/.db_conf

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list && \
    apt-get update && \
    apt-get install -y pwgen mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools && \
    echo "mongodb-org hold" | dpkg --set-selections && echo "mongodb-org-server hold" | dpkg --set-selections && \
    echo "mongodb-org-shell hold" | dpkg --set-selections && \
    echo "mongodb-org-mongos hold" | dpkg --set-selections && \
    echo "mongodb-org-tools hold" | dpkg --set-selections && \
    mkdir -p $DB_CONF

VOLUME /data/mongodb

# reuqired
ENV REPL_SET signit_mongo_cluster
ENV AUTH no
# options
ENV BIND_IP 0.0.0.0
ENV DB_PATH /data/mongodb
ENV DB_PORT 27017
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes
#ENV MONGODB_PASS 
#ENV OPLOG_SIZE      

ADD run.sh $DB_CONF/run.sh
ADD set_mongodb_password.sh $DB_CONF/set_mongodb_password.sh

# ENV MONGO1 "172.25.0.10"
# ENV MONGO2 "172.25.0.11"
# ENV MONGO3 "172.25.0.12"
# mongo $MONGO1 --eval "rs.initiate(); myconf = rs.conf(); myconf.members[0].host = '$MONGO1'; rs.reconfig(myconf,{force:true}); rs.add('$MONGO2'); rs.add('$MONGO3');"


EXPOSE 27017 28017 27018 28018 27019 28019

CMD ["/root/.db_conf/run.sh"]