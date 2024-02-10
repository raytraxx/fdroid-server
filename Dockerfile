FROM docker.io/library/nginx:mainline-bookworm

LABEL author=austozi
LABEL maintainer=austozi

# apksigner is required by modern APK packages.
# This is shipped inside the build-tools package as part of the Android SDK.
# To enable apksigner, we need to install build-tools.
# This specifies the build-tools version to install at image build time.
ARG BUILD_TOOLS_VERSION='33.0.2'

# Define environment variables.
# These can be redefined at run time.
ENV FDROID_REPO_NAME='F-Droid Repository'
ENV FDROID_REPO_ICON='fdroid.svg'
ENV FDROID_REPO_DESCRIPTION='Application repository for Android devices, powered by F-Droid.'
ENV FDROID_REPO_URL='http://localhost'
ENV FDROID_UPDATE_INTERVAL=12h

RUN apt-get update && apt-get install -y --no-install-recommends fdroidserver

# Set default working directory.
RUN mkdir -p /fdroid
WORKDIR /fdroid

# Copy files over to the image.
COPY ./root/ /

# Make scripts executable.
RUN chmod +x /usr/local/bin/*
RUN chmod +x /etc/cont-init.d/*

RUN ln -s /fdroid/repo /usr/share/nginx/html/repo
