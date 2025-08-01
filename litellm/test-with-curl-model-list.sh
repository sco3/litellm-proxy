#!/usr/bin/env -S bash


curl --location "http://localhost:${LITELLM_PORT:-4000}/v1/models" \
    --header "Authorization: Bearer ${LITELLM_MASTER_KEY:-sk-1234}" \
    --header 'Content-Type: application/json' | yq -P 

