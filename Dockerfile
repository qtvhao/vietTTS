FROM debian

WORKDIR /app/
RUN apt update
RUN apt install python3-pip -y

COPY setup.cfg .
COPY setup.py .
COPY vietTTS vietTTS
RUN pip3 install -e .

COPY scripts scripts
COPY assets assets
# RUN apt install python3 -y
RUN apt-get update && apt-get install -y python3.6 python3-distutils python3-pip python3-apt
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN which python3
RUN which python
RUN alias python=/usr/local/bin/python3.6
RUN ls /usr/local/bin/
RUN which python3
RUN apt-get install libsndfile1 -y
RUN pip3 install torchvision matplotlib
RUN bash ./scripts/quick_start.sh
