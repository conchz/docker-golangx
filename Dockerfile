FROM nginx:1.10.3
MAINTAINER Zongzhi Bai <dolphineor@gmail.com>

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Update & Install System Dependencies
RUN apt-get update && \
    apt-get -y install build-essential curl vim python-pip python-setuptools

# Install & Verify Go
ENV GOLANG_VERSION 1.8.1
WORKDIR /root
RUN mkdir -p /root/go/bin
RUN curl -qO https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz \
    && tar -xzf go$GOLANG_VERSION.linux-amd64.tar.gz -C /usr/local \
    && rm -f go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH
RUN go env

# Install Supervisor
RUN mkdir ~/.pip
RUN echo "[global]\nindex-url=http://mirrors.aliyun.com/pypi/simple/\n[install]\ntrusted-host=mirrors.aliyun.com" > ~/.pip/pip.conf
RUN pip install supervisor
RUN pip install supervisor-stdout

# Set Time Zone
RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
