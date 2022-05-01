TEXT=$1
python -m vietTTS.synthesizer \
  --lexicon-file=train_data/lexicon.txt \
  --text="$TEXT" \
  --output=clip.wav
HASH=`echo $TEXT | md5sum | awk '{ print $1 }'`
echo $HASH
aws s3 cp clip.wav "s3://tts-results/$HASH.wav" --endpoint-url "$S3_ENDPOINT_URL"
