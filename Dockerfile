# Build stage
FROM container-registry.oracle.com/graalvm/native-image:23-muslib AS build

WORKDIR /build

# Install UPX
ARG UPX_VERSION=4.2.2
ARG UPX_ARCHIVE=upx-${UPX_VERSION}-amd64_linux.tar.xz
RUN microdnf -y install wget xz && \
    wget -q https://github.com/upx/upx/releases/download/v${UPX_VERSION}/${UPX_ARCHIVE} && \
    tar -xJf ${UPX_ARCHIVE} && \
    rm -rf ${UPX_ARCHIVE} && \
    mv upx-${UPX_VERSION}-amd64_linux/upx . && \
    rm -rf upx-${UPX_VERSION}-amd64_linux

# Copy and compile the application
COPY target/docker-java-1.0-SNAPSHOT.jar /build/
RUN native-image -Os --static --libc=musl -jar docker-java-1.0-SNAPSHOT.jar -o app

# Compress the executable with UPX
RUN ./upx --lzma --best -o app.upx app

# Final stage
FROM scratch
COPY --from=build /build/app.upx /app
CMD ["/app"]