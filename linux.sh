docker build -t tts-base -f base/Dockerfile .
docker build -t viettts .
docker run -it -v "$PWD/output/:/output/" viettts pytest test_app.py
