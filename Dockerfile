FROM amazoncorretto:21
COPY target/docker-java-1.0-SNAPSHOT.jar /opt/app/app.jar
CMD ["java", "-jar", "/opt/app/app.jar"]
