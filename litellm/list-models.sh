#!/usr/bin/env -S bash

set -xueo pipefail

curl --location 'http://0.0.0.0:4000/v1/models' \
        --header 'Authorization: Bearer sk-1234' \
        --header 'Content-Type: application/json' | yq -P
