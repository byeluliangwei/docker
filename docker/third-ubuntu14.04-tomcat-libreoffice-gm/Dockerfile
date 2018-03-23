# IMAGES REPOSITORY   reg.signit.cn:5000/third/ubuntu14.04-tomcat-libreoffice-gm
# DESCRIPTION         安装LibreOffice+GraphicsMagick环境
# VERSION             1.0.0

# 使用此ubuntu基础镜像开始构建
FROM reg.signit.cn:5000/third/ubuntu14.04-tomcat

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 安装字体库
ENV WIN_FONTS_VERSION               0.0.1
RUN cd /tmp && \
    wget http://mvn.ns.me/nexus/service/local/repositories/signit-releases/content/cn/signit/cloudsign-win-fonts/${WIN_FONTS_VERSION}/cloudsign-win-fonts-${WIN_FONTS_VERSION}.gz && \
    mkdir -p /usr/share/fonts && \
    tar -zxvf cloudsign-win-fonts-${WIN_FONTS_VERSION}.gz -C /usr/share/fonts/ && \
    cd /usr/share/fonts/win* && \
    echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty multiverse" >> /etc/apt/sources.list.d/multiverse.list && \
    echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty-updates multiverse" >> /etc/apt/sources.list.d/multiverse.list && \
    echo "deb http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list.d/multiverse.list && \
    apt-get update && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections && \
    apt-get install -y ttf-mscorefonts-installer && \
    apt-get install -y fontconfig && \
    mkfontscale && \
    mkfontdir && \
    fc-cache -f -v && \
    mkdir -p /usr/share/fonts/truetype/arphic && \
    ln -s /usr/share/fonts/win7-default-fonts/uming.ttc /usr/share/fonts/truetype/arphic/uming.ttc && \
    rm -rf /tmp/*
    
# 安装LibreOffice
RUN  apt-get install -y software-properties-common && \
     add-apt-repository ppa:libreoffice/ppa && \
     apt-get update && \
     apt-get install -y ppa-purge && \
     apt-get install -y --no-install-recommends libreoffice
    
# 安装GraphicsMagick依赖
RUN  add-apt-repository ppa:rwky/graphicsmagick && \
     apt-get update && \
     apt-get install -y graphicsmagick && \
     apt-get install -y libgraphicsmagick3
     
# 清理安装
RUN  apt-get autoremove -y software-properties-common && \
     apt-get autoclean && \
     rm -rf /tmp/*