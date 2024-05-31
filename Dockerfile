# Debian latest
FROM debian:latest

# Working directory

RUN mkdir /scripts

WORKDIR /scripts

RUN apt-get update -y

CMD [ "bash" ]