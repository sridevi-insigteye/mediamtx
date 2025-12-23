FROM alpine:3.19

RUN apk add --no-cache \
    ca-certificates \
    ffmpeg \
    tzdata

ENV MEDIAMTX_VERSION=1.8.5

ADD https://github.com/bluenviron/mediamtx/releases/download/v${MEDIAMTX_VERSION}/mediamtx_v${MEDIAMTX_VERSION}_linux_amd64.tar.gz /tmp/mediamtx.tar.gz

RUN tar -xzf /tmp/mediamtx.tar.gz -C /usr/local/bin && \
    rm /tmp/mediamtx.tar.gz

RUN mkdir -p /config
COPY mediamtx.yml /config/mediamtx.yml

# RTSP
EXPOSE 8554/tcp
# HLS
EXPOSE 8888/tcp
# WebRTC
EXPOSE 8889/tcp

CMD ["/usr/local/bin/mediamtx", "/config/mediamtx.yml"]
