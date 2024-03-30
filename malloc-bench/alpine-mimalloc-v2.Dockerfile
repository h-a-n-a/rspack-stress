FROM alpine:3.18 as builder
RUN apk add git build-base cmake linux-headers
RUN git clone -b v2.1.2 --depth 1 https://github.com/microsoft/mimalloc /mimalloc && \
    cd mimalloc && mkdir build && \
    cd build  && cmake .. && make

FROM node:20.11.1-alpine3.18

COPY --chown=root:root --from=builder /mimalloc/build/libmimalloc.so.2 /lib/libmimalloc.so
ENV LD_PRELOAD=/lib/libmimalloc.so
ENV MIMALLOC_LARGE_OS_PAGES=1
ENV CI=1

COPY package.json /app/
COPY pnpm-lock.yaml /app/
WORKDIR /app

RUN corepack pnpm i && corepack pnpm store prune

ADD . /app

CMD ./node_modules/.bin/rspack build