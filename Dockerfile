FROM amazoncorretto:21 AS build

COPY target/docker-java-1.0-SNAPSHOT.jar /app.jar

RUN jdeps --print-module-deps --ignore-missing-deps /app.jar > /deps.info

RUN jlink --compress=0 \
    --module-path ${JAVA_HOME}/jmods \
    --add-modules $(cat /deps.info) \
    --strip-java-debug-attributes \
    --no-header-files \
    --no-man-pages \
    --output /netty-runtime

FROM gcr.io/distroless/java-base-debian11
COPY --from=build /netty-runtime /opt/jdk
ENV PATH=$PATH:/opt/jdk/bin
COPY --from=build /app.jar /opt/app/app.jar
CMD ["java", "-jar", "/opt/app/app.jar"]