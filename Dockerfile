FROM amazoncorretto:21 AS build

COPY target/docker-java-1.0-SNAPSHOT.jar /app.jar

RUN jdeps --print-module-deps --ignore-missing-deps /app.jar > /deps.info

RUN jlink --compress=2 \
    --module-path ${JAVA_HOME}/jmods \
    --add-modules $(cat /deps.info),jdk.crypto.ec \
    --strip-java-debug-attributes \
    --no-header-files \
    --no-man-pages \
    --output /netty-runtime

FROM gcr.io/distroless/base
COPY --from=build /netty-runtime /opt/jdk
ENV PATH=$PATH:/opt/jdk/bin
COPY --from=build /app.jar /opt/app/app.jar
CMD ["java", "-showversion", "-jar", "/opt/app/app.jar"]