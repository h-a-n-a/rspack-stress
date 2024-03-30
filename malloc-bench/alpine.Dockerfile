FROM node:20.11.1-alpine3.18

ENV CI=1

COPY package.json /app/
COPY pnpm-lock.yaml /app/
WORKDIR /app

RUN corepack pnpm i && corepack pnpm store prune

ADD . /app/

CMD ./node_modules/.bin/rspack build