FROM tts-base

COPY setup.cfg .
COPY setup.py .
COPY vietTTS vietTTS
COPY assets assets

RUN pip3 install -e .

COPY scripts scripts

RUN bash ./scripts/quick_start.sh
RUN wget https://huggingface.co/datasets/ntt123/infore/resolve/main/infore_16k.zip && \
    unzip infore_16k.zip -d /app/vietTTS/data && \
    rm infore_16k.zip

#RUN mkdir -p /app/infore_16k
#
#COPY downsample.sh .
#
#RUN bash downsample.sh
#
#RUN rm downsample.sh
#RUN git clone https://github.com/microsoft/DNS-Challenge && \
#    cd DNS-Challenge/ && git checkout -f 8b87a33b2892f147b5c7ad39ea978453730db269 && \
#    cd NSNet2-baseline/ && \
#    python run_nsnet2.py -i /app/infore_16k/ -o /app/infore_16k_denoised -m ./nsnet2-20ms-baseline.onnx

#RUN apt-get install -y zip
#COPY package.sh .
#RUN bash package.sh
#RUN rm package.sh
COPY test_app.py .
COPY app.py .
RUN mkdir /output/
EXPOSE 5000

CMD ["python", "app.py"]
