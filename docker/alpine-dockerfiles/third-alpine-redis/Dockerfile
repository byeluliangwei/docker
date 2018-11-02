# ENVIRONMENT Redis
#
# DATE_TIME 2016年10月17日 11时27分44秒
#
# VERSION 1.0.0

# 使用此ubuntu基础镜像开始构建
FROM 114.215.149.118:5000/signit/cloudsign-ubuntu-14.04

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 安装Redis稳定版
RUN cd /tmp && \
	wget http://download.redis.io/redis-stable.tar.gz && \
	tar xvzf redis-stable.tar.gz && \
	cd redis-stable && \
	make && \
	make install && \
	cp -f src/redis-sentinel /usr/local/bin && \
	mkdir -p /etc/redis && \
	cp -f *.conf /etc/redis && \
	rm -rf /tmp/redis-stable* && \
	sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
	sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
	sed -i 's/^\(dir .*\)$/# \1\ndir \/data\/redis/' /etc/redis/redis.conf && \
	sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf && \
	sed -i 's/^\(protected-mode .*\)$/# \1\nprotected-mode no/' /etc/redis/redis.conf && \
	sed -i 's/^\(appendonly .*\)$/# \1\nappendonly yes/' /etc/redis/redis.conf && \
#   @sginit@redis_config!@#rename -> ded1d8996ea3fa68dc7938757c694917 -> 945db9214491676ca17680281423d569 -> ...
 	sed -i 's/^\(#.* SECURITY .*\)$/\1\nrename-command FLUSHALL ""\nrename-command FLUSHDB ded1d8996ea3fa68dc7938757c694917\nrename-command CONFIG 945db9214491676ca17680281423d569/' /etc/redis/redis.conf && \
	mkdir -p /data/redis
# 定义数据挂载目录(共享数据和防止数据丢失)
VOLUME ["/data/redis"]

# 定义工作目录
WORKDIR /data/redis

# 定义默认启动命令行
# sentinel模式
# CMD ["redis-sentinel", "/etc/redis/sentinel.conf"]
# 单机模式
CMD ["redis-server", "/etc/redis/redis.conf"]

# 需要暴露的端口
EXPOSE 6379