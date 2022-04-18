# pretix-docker-compose

Docker compose file for the Pretix ticketing system.

## Setup

```bash
# 1. Clone
git clone https://github.com/pretix/pretix-docker-compose.git
cd pretix-docker-compose

# 2. Edit the DB password in `.env`.
vim .env

# 3. Edit the DB password and other settings in the `pretix.cfg` file
vim pretix.cfg

# 4. Start Database and Redis
docker-compose up cache db

# 5. When the database has initialized you can start the app
docker-compose up app
```

## Proxy

The reverse proxy is needed for exposing the app to the internet and handling TLS and Certificates.

### Traefik

An example config using `traefik` version 2. Assumes an external network `proxy`, the domain `example.org` pointing to the server and a certificate resolver `cf`.

```yaml
version: '3.8'

networks:
  proxy:
    external: true

services:
  app:
    image: pretix/standalone:stable
    restart: unless-stopped
    command: all
    volumes:
      - ./data/app:/data
      - ./pretix.cfg:/etc/pretix/pretix.cfg:ro
    depends_on:
      - db
      - cache
    networks:
      - default
      - proxy
    labels:
      - traefik.enable=true
      - traefik.http.routers.pretix.rule=Host(`example.org`)
      - traefik.http.routers.pretix.entrypoints=secure
      - traefik.http.routers.pretix.tls.certresolver=cf
```
