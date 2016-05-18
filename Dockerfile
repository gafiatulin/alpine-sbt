FROM java:jre-alpine

ENV SBT_VERSION 0.13.11
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

# Install sbt
RUN apk add --update curl bash && \
    curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
    apk del curl bash && \
    rm -rf /var/cache/apk/* && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built

WORKDIR /app
