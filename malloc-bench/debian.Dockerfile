FROM node:20.11.1-bookworm

ENV CI=1

COPY package.json /app/
COPY pnpm-lock.yaml /app/
COPY .npmrc /app/
WORKDIR /app

RUN corepack pnpm i && corepack pnpm store prune

ADD . /app

RUN apt update && apt install -y time
COPY rspack.linux-x64-gnu.node /app/node_modules/@rspack/binding/

CMD /usr/bin/time -v node ./node_modules/.bin/rspack build