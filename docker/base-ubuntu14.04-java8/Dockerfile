# IMAGES REPOSITORY   reg.signit.cn:5000/base/ubuntu14.04-java8
# DESCRIPTION         安装Java8环境
# VERSION             1.0.0

# 使用此ubuntu基础镜像开始构建
FROM reg.signit.cn:5000/base/ubuntu14.04-base

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 安装Java8运行环境
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"\
    > /etc/apt/sources.list.d/webupd8team-java.list \
    && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"\
    >> /etc/apt/sources.list.d/webupd8team-java.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
    && apt-get update -y \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -y --no-install-recommends oracle-java8-installer=8u131-1~webupd8~2 \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/oracle-jdk8-installer

# 设置Java8系统环境变量
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle