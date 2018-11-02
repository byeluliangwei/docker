# IMAGES REPOSITORY   reg.signit.cn:5000/third/alpine-gitserver-http
# DESCRIPTION         安装gitserver-http环境
# VERSION             1.0.0

# 使用此alpine基础镜像开始构建
FROM reg.signit.cn:5000/third/alpine-nginx

RUN set -x && \
  apk --update upgrade                                  &&  \
  apk add git bash fcgiwrap spawn-fcgi wget             &&  \

  adduser git -h /var/lib/git -D                        &&  \
  adduser nginx git                                     &&  \

  git config --system http.receivepack true             &&  \
  git config --system http.uploadpack true              &&  \
  git config --system user.email "zhd@signit.cn"        &&  \
  git config --system user.name "signit"                &&  \

  ln -sf /dev/stdout /var/log/nginx/access.log          &&  \
  ln -sf /dev/stderr /var/log/nginx/error.log

ADD ./etc /etc
ADD ./entrypoint.sh /usr/local/bin/entrypoint
ADD ./run /etc/services.d/nginx/

RUN chmod +x /etc/services.d/nginx/run && \
    chmod +x /usr/local/bin/entrypoint
