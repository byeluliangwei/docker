# ENVIRONMENT Mysql Latest
#
# VERSION 0.0.1
# 使用此ubuntu基础镜像开始构建
FROM 114.215.149.118:5000/signit/cloudsign-ubuntu-14.04

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

ENV DEBIAN_FRONTEND noninteractive

# Latest MySQL from Oracle offical repos
ADD http://dev.mysql.com/get/mysql-apt-config_0.1.5-2ubuntu14.04_all.deb /tmp/

RUN dpkg -i /tmp/mysql-apt-config_0.1.5-2ubuntu14.04_all.deb && \
	apt-get update &&\
	apt-get -y --force-yes install mysql-server mysql-client libmysqlclient-dev && \
	apt-get install -y psmisc

ADD my.cnf /etc/mysql/my.cnf
RUN chown mysql:mysql /etc/mysql/my.cnf

ADD mysql-start /usr/bin/mysql-start
RUN chown mysql:mysql /usr/bin/mysql-start

VOLUME ["/data/mysql"]

EXPOSE 3306 

CMD ["/usr/bin/mysql-start"]

