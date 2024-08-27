# Base image for Go cross-compilation targeting linux/arm/v7
FROM ghcr.io/dtcooper/raspberrypi-os:bullseye

# Set Go environment variables for ARMv7
ENV GO_VERSION 1.23.0
ENV GOOS linux
ENV GOARCH arm
ENV GOARM 7

# Install dependencies and ARMv7 GCC toolchain
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    gcc \
    gcc-arm-linux-gnueabihf \
    libc6-dev-armhf-cross \
    make \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install Go
RUN curl -OL https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz

# Set Go environment variables
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# Set CC and CXX to the ARMv7 cross-compilers
ENV CC=arm-linux-gnueabihf-gcc
ENV CXX=arm-linux-gnueabihf-g++

RUN mkdir -p /go/src/app

WORKDIR /go/src/app
