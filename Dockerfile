FROM golang:1.8
MAINTAINER Baymax <dolphineor@gmail.com>

RUN apt-get update && apt-get install -y python python-virtualenv python-setuptools supervisor

RUN go get github.com/json-iterator/go
RUN go get github.com/labstack/echo/...
RUN go get github.com/go-sql-driver/mysql
RUN go get github.com/jinzhu/gorm
RUN go get gopkg.in/redis.v5
