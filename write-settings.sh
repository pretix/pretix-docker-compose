#!/usr/bin/env bash

sed -i -e "s/^instance_name=.*$/instance_name=$INSTANCE_NAME/" /etc/pretix/pretix.cfg
sed -i -e "s/^name=.*$/name=$POSTGRES_DB/" /etc/pretix/pretix.cfg
sed -i -e "0,/^user=.*$/s/^user=.*$/user=$POSTGRES_USER/" /etc/pretix/pretix.cfg
sed -i -e "0,/^password=.*$/s/^password=.*$/password=$POSTGRES_PASSWORD/" /etc/pretix/pretix.cfg
sed -i -e "s/^secret=.*$/secret=$DJANGO_SECRET/" /etc/pretix/pretix.cfg
sed -i -e "s/^from=.*$/from=$MAIL_FROM/" /etc/pretix/pretix.cfg
sed -i -e "s/^currency=.*$/currency=$CURRENCY/" /etc/pretix/pretix.cfg
