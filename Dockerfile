FROM openjdk:jre-alpine

ENV sbt_version 1.1.4
ENV sbt_home /usr/local/sbt
ENV PATH ${PATH}:${sbt_home}/bin

RUN apk --no-cache --update add bash wget && mkdir -p "$sbt_home" && \
    wget -q --no-check-certificate -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget -q --no-check-certificate https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && apk add glibc-2.25-r0.apk && rm glibc-2.25-r0.apk && \
    wget -qO - --no-check-certificate "https://github.com/sbt/sbt/releases/download/v$sbt_version/sbt-$sbt_version.tgz" | tar xz -C $sbt_home --strip-components=1 && \
    apk del wget && \
    sbt sbtVersion

WORKDIR /app
