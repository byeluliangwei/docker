# IMAGES REPOSITORY   reg.signit.cn:5000/third/ubuntu14.04-java8-opencv2
# DESCRIPTION         安装OpenCV2环境
# VERSION             1.0.0

# 使用此ubuntu基础镜像开始构建
FROM reg.signit.cn:5000/base/ubuntu14.04-java8

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

ENV OPENCV_VERSION              3.2.0
ENV TARGET_JAVA_VERSION         8
ENV TARGET_JAVA_LIB_VERSION     320

# 安装opencv2依赖环境
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \ 
    build-essential \
    cmake \
    unzip \
    ant \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libdc1394-22-dev 

# 安装opencv2环境
RUN wget --no-check-certificate https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip -O opencv-${OPENCV_VERSION}.zip && \
    unzip opencv-${OPENCV_VERSION}.zip && \
    cd opencv-${OPENCV_VERSION}/ && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_TESTS=OFF .. && \
    make -j${TARGET_JAVA_VERSION} && make install -j${TARGET_JAVA_VERSION} && make clean && \
    cd ../ && rm -rf opencv-${OPENCV_VERSION} && \
    cd ../ && \
    rm opencv-${OPENCV_VERSION}.zip && \
    set CLASSPATH=/usr/local/share/OpenCV/java/opencv-${TARGET_JAVA_LIB_VERSION}.jar && \
    cp /usr/local/share/OpenCV/java/libopencv_java${TARGET_JAVA_LIB_VERSION}.so /lib/libopencv_java${TARGET_JAVA_LIB_VERSION}.so

# 清理安装后的依赖
RUN apt-get autoremove -y unzip cmake ant && \
    apt-get autoclean