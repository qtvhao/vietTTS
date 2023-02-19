set -e
#docker build -t tts-base -f base/Dockerfile .
docker build -t viettts .
docker run -it viettts python3 -m vietTTS.synthesizer --text "Xin cho" --output /output/clip0.wav --lexicon-file assets/infore/lexicon.txt --silence-duration 0.2
docker run -it viettts pytest test_app.py
docker run -it -p 80:80 --name tts -v "$PWD/output/:/output/" viettts
