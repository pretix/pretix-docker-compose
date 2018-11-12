# pretix-docker-compose

Docker Compose setup for pretix. Not officially maintained!

## What is this?

This is a small example setup to run pretix with docker-compose.

## Prepare

* Change the `env.ini` to fit your needs
* Git checkout including submodules `git submodule update --init --recursive`
* If you want to build against latest master, run `git submodule update --init --recursive --remote` instead

## Configuration

|Name|Default Value|Usage|
|----|-------------|-----|
|POSTGRES_DB|pretix|Name of the database does not need to be changed|
|POSTGRES_USER|pretix|Database user, should be changed before first run to a randomn alphanumeric value|
|POSTGRES_PASSWORD|pretix|Database user, should be changed before first run to a long randomn alphanumeric value|
|DJANGO_SECRET|eehucheethie1cuW7bieKooviecoFooj9yepai1Oec3aevah3f|Django secret used to encrypt database values, change before first use to a long randomn alphanumeric value and include it in your backup|
|MAIL_FROM|tickets@ChangeMeToYourPretixDomain.arpa|Change before first run to your own domain. This is the address that pretix will send as. Don't forget to add the host to your spf record.|
|INSTANCE_NAME|"My pretix installation"|Your instance name, used to differenciate between multiple instances. Should only be changed before first run.|
|CURRENCY|EUR|Your local currency, can be any string. Should be changed before first run.|

## Run with nginx container

```bash
docker-compose -f docker-compose.yml -f docker-compose.nginx.yml up --force-recreate --build
```

No volumes are shared with the host.
Named Volumes will be used instead.

## Run without nginx container

```bash
docker-compose up --force-recreate --build
```

## Run with nginx and existing haproxy

### Preparation

* A working haproxy setup
* A precreated transfer network named `HAProxy2Pretix` with your haproxy having `10.255.0.1/30`
* Your haproxy is looking for pretix on the ip `10.255.0.2` on the `HAProxy2Pretix` interface

### Starting

```bash
docker-compose -f docker-compose.yml -f docker-compose.nginx.yml -f docker-compose.toHAProxy.yml up --force-recreate --build
```

### Default login

Username: admin@localhost
Password: admin
