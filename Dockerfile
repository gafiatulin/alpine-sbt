FROM openjdk:jre-alpine

ENV SBT_VERSION 0.13.13
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

RUN apk --no-cache --update add ca-certificates openssl bash && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    apk --no-cache -X http://apkproxy.heroku.com/sgerrand/alpine-pkg-glibc add glibc && \
    wget -q -O - "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x && \
    cp -a sbt-launcher-packaging-$SBT_VERSION/* /usr/local && rm -rf sbt-launcher-packaging-$SBT_VERSION && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

WORKDIR /app
