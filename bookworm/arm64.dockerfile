FROM dtcooper/raspberrypi-os:bookworm

# Set Go environment variables for ARM64
ENV GO_VERSION 1.23.0
ENV GOOS linux
ENV GOARCH arm64

# Install dependencies and ARM64 GCC toolchain
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    gcc \
    gcc-aarch64-linux-gnu \ 
    libc6-dev-arm64-cross \
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

# Set CC and CXX to the ARM64 cross-compilers
# These will only be used if CGO_ENABLED=1 is set
ENV CC=aarch64-linux-gnu-gcc
ENV CXX=aarch64-linux-gnu-g++

RUN mkdir -p /go/src/app

WORKDIR /go/src/app
