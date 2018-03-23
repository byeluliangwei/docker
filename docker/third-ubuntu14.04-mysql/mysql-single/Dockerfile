# IMAGES REPOSITORY   reg.signit.cn:5000/third/ubuntu14.04-mysql
# DESCRIPTION         安装Mysql数据库
# VERSION             1.0.0
# 使用此ubuntu基础镜像开始构建
FROM reg.signit.cn:5000/base/ubuntu14.04-base

#指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

ENV DEBIAN_FRONTEND noninteractive

# Latest MySQL from Oracle offical repos
ADD http://dev.mysql.com/get/mysql-apt-config_0.1.5-2ubuntu14.04_all.deb /tmp/

RUN dpkg -i /tmp/mysql-apt-config_0.1.5-2ubuntu14.04_all.deb && \
	apt-get update &&\
	apt-get -y --force-yes install mysql-server mysql-client libmysqlclient-dev && \
	apt-get install -y psmisc
	
# 添加独立的外部文件
ADD ./run /etc/services.d/mysql/
RUN chmod +x /etc/services.d/mysql/run

# 添加mysql服务器配置文件
ADD my.cnf /etc/mysql/my.cnf
RUN chown mysql:mysql /etc/mysql/my.cnf && \
    chown mysql:mysql -R /var/lib/mysql

# 添加mysql服务器启动脚本
ADD mysql-start /usr/bin/mysql-start
RUN chown mysql:mysql /usr/bin/mysql-start

VOLUME ["/data/mysql","/data/mysql/log"]

EXPOSE 3306