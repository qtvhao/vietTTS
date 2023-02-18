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
EXPOSE 5000

CMD ["python", "app.py"]
