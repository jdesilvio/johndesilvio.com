# [johndesilvio.com](johndesilvio.com)

## Built with:

* Python 3.6
* Flask
* uWSGI
* NGINX
* Docker

---

#### Ensure a clean build

     docker-compose stop && \
     docker-compose rm -f && \
     docker-compose pull && \
     docker-compose build --no-cache && \
     docker-compose up -d --force-recreate --remove-orphans
