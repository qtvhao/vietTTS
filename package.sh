#!/bin/bash
set -e

cd /app/infore_16k_denoised

cp /app/vietTTS/data/InfoRe/*.txt .

zip -r /app/infore_16k_denoised.zip .

cd -

