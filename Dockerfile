FROM maven:3-jdk-8 as builder
MAINTAINER matt.brewster@base2s.com
COPY . /build
WORKDIR /build
RUN mvn clean package

FROM sonatype/nexus3:3.16.1
USER root
RUN mkdir -p /opt/sonatype/nexus/system/com/larscheidschmitzhermes/nexus3-github-oauth-plugin/docker/
COPY --from=builder /build/target/nexus3-github-oauth-plugin-*.kar /opt/sonatype/nexus/deploy
USER nexus
