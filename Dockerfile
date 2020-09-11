FROM alpine:3.12

RUN apk add --no-cache git

COPY log.sh /log.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
