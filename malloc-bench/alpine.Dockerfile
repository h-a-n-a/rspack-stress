FROM node:20.11.1-alpine3.18

ENV CI=1

COPY package.json /app/
COPY pnpm-lock.yaml /app/
COPY .npmrc /app/
WORKDIR /app

RUN corepack pnpm i && corepack pnpm store prune

ADD . /app/
COPY rspack.linux-arm64-musl.node /app/node_modules/@rspack/binding/

CMD /usr/bin/time -v node ./node_modules/.bin/rspack build