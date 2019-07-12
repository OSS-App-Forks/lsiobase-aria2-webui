FROM lsiobase/alpine.nginx:3.9

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="lukasmrtvy"

ARG ARIA2WEBUI_VERSION
ARG ARIA2_VERSION

ENV ARIA2WEBUI_VERSION fb9d758d5cdc2be0867ee9502c44fd17560f5d24
ENV ARIA2_VERSION 1.34.0-r1
ENV ADMIN_AUTH=off

RUN \
    apk add --no-cache tar curl openssl aria2=${ARIA2_VERSION} && \
    mkdir -p /data/aria2c-webui /tmp/aria2c-webui /data/config && \
    curl -sSL https://github.com/ziahamza/webui-aria2/archive/${ARIA2WEBUI_VERSION}.tar.gz | tar xz -C /tmp/aria2c-webui --strip-components=1 && \
    cp -R /tmp/aria2c-webui/docs/* /data/aria2c-webui && \
    apk del tar curl && \
    rm -rf /tmp/*

COPY root/ /

EXPOSE 4040

VOLUME ["/data/downloads/"]
