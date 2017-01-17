#!/bin/bash
# start-services.sh

set -e

args="$@"

for service in $args; do
    sudo service $service restart
done

exec /bin/bash
