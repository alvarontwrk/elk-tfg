FROM alpine:latest
RUN apk add --no-cache bash
RUN apk add --no-cache openssl
RUN mkdir workdir
RUN mkdir /scripts
WORKDIR /workdir
COPY script.sh /scripts
ENTRYPOINT bash /scripts/script.sh
