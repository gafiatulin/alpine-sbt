FROM openjdk:jre-alpine

ENV SBT_VERSION 0.13.15
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

RUN apk --no-cache --update add ca-certificates openssl bash wget && mkdir -p "$SBT_HOME" && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.25-r0/glibc-2.25-r0.apk && apk add glibc-2.25-r0.apk && \
    wget -qO - --no-check-certificate "https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar xz -C $SBT_HOME --strip-components=1 && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

WORKDIR /app
