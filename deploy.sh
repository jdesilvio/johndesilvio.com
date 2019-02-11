#!/bin/bash

set -e

echo && echo '### Set locale and variables' && echo
export LANG=en_US.UTF-8
export LANGUAGE=en_US:
export DEBIAN_FRONTEND=noninteractive
compose_url='https://github.com/docker/compose/releases/download'
compose_version='1.23.2'
compose_dist="docker-compose-$(uname -s)-$(uname -m)"
if [[ -v CERT_EMAIL ]]; then
  email_opt="--email=$CERT_EMAIL"
else
  email_opt=''
fi

echo && echo '### Install cURL' && echo
apt-get update &&
apt-get install -y \
  curl git software-properties-common tzdata

echo && echo '### Install Docker' && echo
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

echo && echo '### Install Docker Compose' && echo
curl \
  -L "$compose_url/$compose_version/$compose_dist" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo && echo '### Install Certbot' && echo
apt-get update &&
add-apt-repository -y universe &&
add-apt-repository -y ppa:certbot/certbot &&
apt-get update &&
apt-get install -y certbot python-certbot-nginx

echo && echo '### Confirming installation...'
echo "... Docker version: $( docker --version )"
echo "... Docker Compose version: $( docker-compose --version )"
echo "... Certbot version: $( certbot --version )"

echo && echo '### Build and deploy for Certbot' && echo
docker-compose -f docker-compose-cert.yml stop &&
docker-compose -f docker-compose-cert.yml rm -f &&
docker-compose -f docker-compose-cert.yml pull &&
docker-compose -f docker-compose-cert.yml build --no-cache &&
docker-compose -f docker-compose-cert.yml up -d \
  --force-recreate \
  --remove-orphans

echo && echo '### Confirming Certbot build deployment...'
echo "$( docker ps )"

echo && echo '### Generate certs' && echo
gen_cert="certbot certonly --webroot \
  $email_opt \
  -w /root/certs-data/ \
  -d johndesilvio.com \
  -d www.johndesilvio.com"
eval $gen_cert
certbot renew

echo && echo '### Build and deploy for Production' && echo
docker-compose stop &&
docker-compose rm -f &&
docker-compose pull &&
docker-compose build --no-cache &&
docker-compose up -d \
  --force-recreate \
  --remove-orphans

echo && echo '### Confirming produciton build deployment...'
echo "$( docker ps )"

echo
echo '############################'
echo '### DEPLOYMENT COMPLETE! ###'
echo '############################'
echo
