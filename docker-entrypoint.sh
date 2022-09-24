#!/bin/bash
# set -e

screen -dmS gotify-sync gotify-sync.sh

exec "$@"
