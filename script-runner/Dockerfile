FROM alpine:latest
RUN apk add --no-cache bash
RUN apk add --no-cache openssl
RUN mkdir volume
RUN mkdir workdir
WORKDIR /workdir
COPY script.sh /workdir
ENTRYPOINT bash /workdir/script.sh
