#!/bin/bash
# wait-for-services.sh

set -e

cmd="$@"

service mysql restart

exec $cmd
