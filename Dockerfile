FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-runtime

WORKDIR /app

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/ntt123/vietTTS.git

RUN pip install -r /app/vietTTS/requirements.txt

EXPOSE 5000

CMD ["python", "/app/vietTTS/server.py"]
