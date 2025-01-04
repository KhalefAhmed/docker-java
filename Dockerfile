FROM amazoncorretto:21 AS build
RUN  apt-get update && apt-get -y upgrade && apt-get -y install build-essential
COPY target/docker-java-1.0-SNAPSHOT.jar /opt/app/app.jar
COPY dep/ /opt/app/dep/
COPY aot.cfg /opt/app/
RUN jaotc --output /opt/app/app-native.so --compile-commands /opt/app/aot.cfg --module java.base --jar /opt/app/app.jar -J-cp -J"./:/opt/app/dep/*" --info

FROM amazoncorretto:21 AS runtime
COPY --from=build  /opt/app/app-native.so /opt/app/
COPY --from=build  /opt/app/app.jar /opt/app/
CMD ["java", "-XX:AOTLibrary=/opt/app/app-native.so", "-jar", "/opt/app/app.jar"]