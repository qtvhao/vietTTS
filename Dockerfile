FROM pytorch/pytorch

WORKDIR /app

RUN apt-get update && apt-get install -y git

#RUN git clone https://github.com/qtvhao/vietTTS.git

COPY requirements.txt .

RUN pip3 install -r requirements.txt

COPY setup.cfg .
COPY setup.py .
COPY vietTTS vietTTS
COPY assets assets

RUN pip3 install -e .
RUN apt-get update && apt-get install -y wget
COPY scripts scripts
RUN apt-get update && apt-get install libsndfile1 -y
RUN bash ./scripts/quick_start.sh
RUN python ./scripts/download_aligned_infore_dataset.py
RUN wget https://huggingface.co/datasets/ntt123/infore/resolve/main/infore_16k.zip && \
    unzip infore_16k.zip -d /app/vietTTS/data && \
    rm infore_16k.zip
RUN apt-get update && apt-get install -y sox
RUN pip3 install soundfile librosa
RUN pip3 install onnxruntime==1.11.1

EXPOSE 5000

CMD ["python", "app.py"]
