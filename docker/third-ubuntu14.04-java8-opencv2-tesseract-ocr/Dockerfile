# IMAGES REPOSITORY   reg.signit.cn:5000/third/ubuntu14.04-java8-opencv2-tesseract-ocr
# DESCRIPTION         安装OpenCV2+Tesseract-OCR环境
# VERSION             1.0.0

# 使用此ubuntu基础镜像开始构建
FROM reg.signit.cn:5000/third/ubuntu14.04-java8-opencv2

# 指定镜像创建者和联系方式
MAINTAINER RyanChang zhd@signit.cn

# 图像识别相关环境变量
ENV TESSDATA_PREFIX             /usr/local/share/tessdata

# 安装Tesseract-OCR环境
RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository -y ppa:alex-p/tesseract-ocr
RUN apt-get update && apt-get install -y tesseract-ocr 
RUN mkdir -p ${TESSDATA_PREFIX} && \
	wget --no-check-certificate https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata && \
	wget --no-check-certificate https://github.com/tesseract-ocr/tessdata/raw/master/chi_sim.traineddata && \
	mv *.traineddata ${TESSDATA_PREFIX}


# 清理安装后的依赖
RUN apt-get autoremove && \
    apt-get autoclean