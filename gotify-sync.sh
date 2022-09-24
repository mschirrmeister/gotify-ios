#!/usr/bin/env bash

# set -x

token="${GOTIFY_TOKEN}"
uri="ws://${GOTIFY_SERVER}/stream"

function notify() {
while read line
do
    ntfy -t Gotify send "$(echo ${line} | jq -r '.message')"
done < <(websocat -H "X-Gotify-Key: ${token}" -t "${uri}")
}

notify
