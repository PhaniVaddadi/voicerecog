FROM python:3.7

COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt
RUN pip3 install SoundFile
RUN pip3 install -U scikit-learn scipy matplotlib


RUN wget https://launchpadlibrarian.net/493995427/ffmpeg_4.3.1.orig.tar.xz
RUN tar -xzf ffmpeg_4.3.1.orig.tar.xz; rm -r ffmpeg_4.3.1.orig.tar.xz
RUN cd ./ffmpeg_4.3.1; ./configure --enable-gpl --enable-libmp3lame --enable-decoder=mjpeg,png --enable-encoder=png --enable-openssl --enable-nonfree

RUN cd ./ffmpeg_4.3.1; make
RUN  cd ./ffmpeg_4.3.1; make install



RUN apt-get update -y && apt-get install -y --no-install-recommends build-essential gcc \libsndfile1
ADD . /app.py


# Use subdirectory as working directory
WORKDIR /app

# Install extra requirements for actions code, if necessary (uncomment next line)
#RUN pip3 install -r requirements.txt

COPY . /app

ENTRYPOINT [ "python3" ]

CMD ["app.py"]


