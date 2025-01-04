FROM amazoncorretto:21 AS build
RUN ["jlink", "--compress=2", \
    "--module-path", "${JAVA_HOME}/jmods", \
    "--add-modules", "java.base,java.logging,java.naming,java.xml,jdk.sctp,jdk.unsupported", \
    "--strip-java-debug-attributes", "--no-header-files", "--no-man-pages", \
    "--output", "/netty-runtime"]

FROM gcr.io/distroless/base
COPY --from=build  /netty-runtime /opt/jdk
ENV PATH=$PATH:/opt/jdk/bin
COPY target/docker-java-1.0-SNAPSHOT.jar /opt/app/app.jar
CMD ["java", "-showversion", "-jar", "/opt/app/app.jar"]