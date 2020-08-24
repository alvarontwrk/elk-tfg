FROM python:3.6-slim
COPY . /srv/flask_app
WORKDIR /srv/flask_app
RUN apt-get clean  && apt-get -y update
RUN apt-get -y install nginx  && apt-get -y install python3-dev \
    && apt-get -y install build-essential && apt-get -y install netcat
RUN pip3 install -r requirements.txt --src /usr/local/src
COPY nginx.conf /etc/nginx
RUN chmod +x ./start.sh
CMD ["./start.sh"]
