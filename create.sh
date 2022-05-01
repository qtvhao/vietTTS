TEXT="hôm qua em tới trường"
python -m vietTTS.synthesizer \
  --lexicon-file=train_data/lexicon.txt \
  --text="$TEXT" \
  --output=clip.wav
HASH=`echo $TEXT | md5sum | awk '{ print $1 }'`
echo $HASH
aws s3 cp clip.wav "s3://tts-results/$HASH.mp3" --endpoint-url "https://storageapis-9000.weiseheim.com"
