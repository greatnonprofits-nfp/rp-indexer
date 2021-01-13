FROM golang:1.13-alpine

WORKDIR /app

RUN apk update \
  && apk add --virtual build-deps gcc git \
  && rm -rf /var/cache/apt/*

RUN addgroup -S ccl_indexer \
  && adduser -S -G ccl_indexer ccl_indexer

COPY . .

RUN go install -v ./cmd/...
RUN chown -R ccl_indexer /app

USER ccl_indexer

EXPOSE 80
ENTRYPOINT ["rp-indexer"]