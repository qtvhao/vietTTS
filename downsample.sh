#!/bin/bash
set -e

mkdir -p /app/infore_16k

for file in /app/vietTTS/data/InfoRe/*.wav
do
  echo "Downsampling $file"
  sox "$file" -r 16000 -c 1 -b 16 -e signed-integer --norm=-3 "/app/infore_16k/$(basename "$file")"
  rm "$file"
done
