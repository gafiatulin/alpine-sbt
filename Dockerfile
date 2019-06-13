# Defaults if not specified in --build-arg
ARG sbt_version=1.1.4
ARG sbt_home=/usr/local/sbt

FROM openjdk:jre-alpine as unzip
ARG sbt_version
ARG sbt_home

# Cleverly placed here for caching reasons
RUN apk add --no-cache --update bash

# Download and extract from archive
RUN apk add --no-cache --update wget
RUN mkdir -pv "$sbt_home"
RUN wget -qO - "https://github.com/sbt/sbt/releases/download/v$sbt_version/sbt-$sbt_version.tgz" >/tmp/sbt.tgz
RUN tar xzf /tmp/sbt.tgz -C "$sbt_home" --strip-components=1


# Make a clean image (i.e., without extra packages)
FROM openjdk:jre-alpine as release
ARG sbt_home

# sbt requires bash at run-time.
RUN apk add --no-cache --update bash  

COPY --from=unzip $sbt_home $sbt_home
RUN ln -sv "$sbt_home"/bin/sbt /usr/bin/

# This triggers a bunch of useful downloads.
RUN sbt sbtVersion
