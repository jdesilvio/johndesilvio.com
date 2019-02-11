#!/bin/bash

set -e

echo '### Set locale'
export LANG=en_US.UTF-8
export LANGUAGE=en_US:
export DEBIAN_FRONTEND=noninteractive
compose_url='https://github.com/docker/compose/releases/download'
compose_version='1.23.2'
compose_dist="docker-compose-$(uname -s)-$(uname -m)"

echo '### Install cURL'
apt-get update &&
apt-get install -y \
  curl git software-properties-common tzdata

echo '### Install Docker'
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

echo '### Install Docker Compose'
curl \
  -L "$compose_url/$compose_version/$compose_dist" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo '### Install Certbot'
apt-get update &&
add-apt-repository -y universe &&
add-apt-repository -y ppa:certbot/certbot &&
apt-get update &&
apt-get install -y certbot python-certbot-nginx

echo '### Confirming setup...'
echo "... Docker version: $( docker --version )"
echo "... Docker Compose version: $( docker-compose --version )"
echo "... Certbot version: $( certbot --version )"
echo '### Setup complete!'
