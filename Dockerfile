FROM ghcr.io/graalvm/graalvm-ce:22.1.0 AS build
RUN gu install native-image
COPY target/docker-java-1.0-SNAPSHOT.jar /opt/app/
WORKDIR /opt/app/
RUN native-image -jar ./docker-java-1.0-SNAPSHOT.jar

FROM scratch
COPY --from=build  /opt/app/docker-java-1.0-SNAPSHOT /
CMD ["/app/docker-java-1.0-SNAPSHOT"]