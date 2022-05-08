FROM debian

WORKDIR /app/
RUN apt update
RUN apt install python3-pip -y
RUN apt-get install libsndfile1 zip awscli -y
RUN apt-get update && apt-get install -y python3.6 python3-distutils python3-pip python3-apt
RUN pip3 install torchvision matplotlib

COPY setup.cfg .
COPY setup.py .
COPY vietTTS vietTTS

RUN pip3 install -e .

COPY scripts scripts
COPY assets assets
# RUN apt install python3 -y
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN alias python=/usr/local/bin/python3.6
RUN ls /usr/local/bin/
RUN bash ./scripts/quick_start.sh
RUN bash ./scripts/download_aligned_infore_dataset.sh
RUN aws configure set aws_access_key_id admin
RUN aws configure set aws_secret_access_key password
RUN python -m vietTTS.nat.duration_trainer
RUN python -m vietTTS.nat.acoustic_trainer
COPY create.sh .
