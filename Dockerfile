FROM pytorch/pytorch

WORKDIR /app

RUN apt-get update && apt-get install -y git

COPY requirements.txt .

RUN pip3 install -r requirements.txt

COPY setup.cfg .
COPY setup.py .
COPY vietTTS vietTTS
COPY assets assets

RUN pip3 install -e .
RUN apt-get update && apt-get install -y wget
COPY scripts scripts
RUN apt-get update && apt-get install -y libsndfile1

RUN apt-get update && apt-get install -y sox
RUN pip3 install soundfile librosa
RUN pip3 install onnxruntime==1.11.1

RUN apt-get update && apt-get install -y wget
RUN wget https://huggingface.co/datasets/ntt123/infore/resolve/main/infore_16k.zip && \
    unzip infore_16k.zip -d /app/vietTTS/data && \
    rm infore_16k.zip

RUN mkdir -p /app/infore_16k

COPY downsample.sh .

RUN bash downsample.sh

RUN rm downsample.sh

EXPOSE 5000

CMD ["python", "app.py"]
