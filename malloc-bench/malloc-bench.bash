#!/usr/bin/env bash

cases="debian alpine alpine-mimalloc-v1 alpine-mimalloc-v2"

for name in $cases; do
  echo "Building image for ${name}"
  docker build --tag "rspack-malloc-bench:$name" -f "${name}.Dockerfile" ../app
  echo
done
for name in $cases; do
  echo "Running case ${name}"
  docker run --rm "rspack-malloc-bench:$name" ./node_modules/@rspack/cli/bin/rspack build
  echo
done
