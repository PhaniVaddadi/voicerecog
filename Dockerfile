FROM python:3.7

COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:mc3man/trusty-media
RUN apt-get update
RUN apt-get install -y ffmpeg
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
