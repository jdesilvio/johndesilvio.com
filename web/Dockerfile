FROM python:3.6.1-alpine

MAINTAINER John DeSilvio "john.desilvio@yahoo.com"

RUN apk add --update alpine-sdk
RUN apk add linux-headers \
            vim \
            bash \
            bash-doc \
            bash-completion

RUN pip install flask==0.12.2
RUN pip install uwsgi==2.0.15

ENV FLASK_APP /usr/src/app/run.py
