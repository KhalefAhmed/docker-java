# Build stage
FROM container-registry.oracle.com/graalvm/native-image:23-muslib AS build

WORKDIR /build
# Copy and compile the application
COPY target/docker-java-1.0-SNAPSHOT.jar /build/
RUN native-image -Os --static --libc=musl -jar docker-java-1.0-SNAPSHOT.jar -o app

# Final stage
FROM scratch
COPY --from=build /build/app /app
CMD ["/app"]