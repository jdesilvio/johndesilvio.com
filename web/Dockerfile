FROM python:3.6.1-alpine

MAINTAINER John DeSilvio "john.desilvio@yahoo.com"

RUN apk add --update alpine-sdk
RUN apk add linux-headers
RUN apk add vim
RUN pip install flask==0.12.2
RUN pip install uwsgi==2.0.15
RUN apk add bash bash-doc bash-completion

ENV FLASK_APP /usr/src/app/app.py
