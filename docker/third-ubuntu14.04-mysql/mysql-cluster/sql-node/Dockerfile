#ENVIRONMENT Mysql Cluster7.5 - SQL node
#
#VERSION 0.0.1
#使用此ubuntu基础镜像开始构建
FROM 114.215.149.118:5000/signit/cloudsign-ubuntu-14.04

#指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

ENV METHODMAKER_PACKAGE_URL ftp://rpmfind.net/linux/epel/7/x86_64/p/perl-Class-MethodMaker-2.20-1.el7.x86_64.rpm
ENV LIB_PACKAGE_URL https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.5/mysql-cluster-community-libs-7.5.4-1.el7.x86_64.rpm
ENV COMMON_PACKAGE_URL https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.5/mysql-cluster-community-common-7.5.4-1.el7.x86_64.rpm
ENV CLIENT_PACKAGE_URL https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.5/mysql-cluster-community-client-7.5.4-1.el7.x86_64.rpm
ENV SERVER_PACKAGE_URL https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.5/mysql-cluster-community-server-7.5.4-1.el7.x86_64.rpm

RUN yum install -y libaio $METHODMAKER_PACKAGE_URL $LIB_PACKAGE_URL $COMMON_PACKAGE_URL $CLIENT_PACKAGE_URL $SERVER_PACKAGE_URL

ADD my.cnf /etc/my.cnf
RUN chmod 644 /etc/my.cnf

EXPOSE 3306

ADD run.sh /home/mysql/run-mysqlndb.sh
RUN chmod +x /home/mysql/run-mysqlndb.sh
ENTRYPOINT ["/home/mysql/run-mysqlndb.sh"]
