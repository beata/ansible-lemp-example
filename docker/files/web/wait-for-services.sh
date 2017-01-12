#!/bin/bash
# wait-for-services.sh

set -e

cmd="$@"

service nginx restart
service php7.0-fpm restart

exec $cmd
