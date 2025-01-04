FROM amazoncorretto:21
COPY target/docker-java-1.0-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]
