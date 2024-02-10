FROM docker.io/library/debian:bookworm-slim

LABEL author=austozi
LABEL maintainer=austozi

# Define environment variables.
# These can be redefined at run time.
ENV FDROID_REPO_NAME='F-Droid Repository'
ENV FDROID_REPO_ICON='fdroid.svg'
ENV FDROID_REPO_DESCRIPTION='Application repository for Android devices, powered by F-Droid.'
ENV FDROID_REPO_URL='http://localhost/repo'
ENV FDROID_UPDATE_INTERVAL=12h

RUN apt-get update && apt-get install -y --no-install-recommends nginx fdroidserver

# Set default working directory.
RUN mkdir -p /fdroid
WORKDIR /fdroid

RUN ln -s /fdroid/repo /var/www/html/repo

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
