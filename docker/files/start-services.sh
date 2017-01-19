#!/bin/bash
# start-services.sh

set -e

args="$@"

if [ -d "/srv/www/sites/api" ]; then
    sudo usermod -u 1000 www-data
fi

for service in $args; do
    sudo service $service restart
done

exec tail -f /dev/null
