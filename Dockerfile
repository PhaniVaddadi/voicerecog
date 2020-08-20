FROM python:3.7

COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt
RUN apt-get update ; apt-get install -y git build-essential gcc make yasm autoconf automake cmake libtool checkinstall libmp3lame-dev pkg-config libunwind-dev zlib1g-dev libssl-dev

RUN apt-get update \
    && apt-get clean \
    && apt-get install -y --no-install-recommends libc6-dev libgdiplus wget software-properties-common

#RUN RUN apt-add-repository ppa:git-core/ppa && apt-get update && apt-get install -y git

RUN wget https://www.ffmpeg.org/releases/ffmpeg-4.0.2.tar.gz
RUN tar -xzf ffmpeg-4.0.2.tar.gz; rm -r ffmpeg-4.0.2.tar.gz
RUN cd ./ffmpeg-4.0.2; ./configure --enable-gpl --enable-libmp3lame --enable-decoder=mjpeg,png --enable-encoder=png --enable-openssl --enable-nonfree


RUN cd ./ffmpeg-4.0.2; make
RUN  cd ./ffmpeg-4.0.2; make install
RUN pip3 install SoundFile
RUN pip3 install -U scikit-learn scipy matplotlib

RUN apt-get update -y && apt-get install -y --no-install-recommends build-essential gcc \libsndfile1
ADD . /app.py


# Use subdirectory as working directory
WORKDIR /app

# Install extra requirements for actions code, if necessary (uncomment next line)
#RUN pip3 install -r requirements.txt

COPY . /app

ENTRYPOINT [ "python3" ]

CMD ["app.py"]


