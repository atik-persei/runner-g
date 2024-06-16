# Set the Android SDK version
ARG android_sdk_ver=34

# Use the specified Android SDK image as the base image
FROM ghcr.io/cirruslabs/android-sdk:${android_sdk_ver}

# Set Flutter version and build revision
ARG flutter_ver=3.22.2
ARG build_rev=0

# Set the working directory
WORKDIR /app
COPY . .

# Set environment variables for Flutter
ENV FLUTTER_HOME=/usr/local/flutter \
    FLUTTER_VERSION=${flutter_ver} \
    PATH=$PATH:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin

# Install dependencies and Flutter
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        ca-certificates net-tools build-essential clang cmake lcov \
        libgtk-3-dev liblzma-dev ninja-build pkg-config && \
    update-ca-certificates && \
    \
    # Download and install Flutter
    curl -fL -o /tmp/flutter.tar.xz \
        https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${flutter_ver}-stable.tar.xz && \
    tar -xf /tmp/flutter.tar.xz -C /usr/local/ && \
    git config --global --add safe.directory /usr/local/flutter && \
    flutter config --enable-android --enable-linux-desktop --enable-web --no-enable-ios && \
    flutter precache --universal --linux --web --no-ios && \
    (yes | flutter doctor --android-licenses) && \
    flutter --version && \
    \
    # Clean up
    rm -rf /var/lib/apt/lists/* /tmp/*

# Set the default command to keep the container running
CMD ["sleep", "infinity"]
