#!/usr/bin/env -S bash


curl --location "http://localhost:${LITELLM_PORT:-4000}/v1/models" \
    --header "Authorization: Bearer ${LITELLM_MASTER_KEY:-sk-1234}" \
    --header 'Content-Type: application/json'

time curl -s -v "http://localhost:${LITELLM_PORT:-4000}/chat/completions" \
    --header "Authorization: Bearer ${LITELLM_MASTER_KEY:-sk-1234}" \
    --header "Content-Type: application/json" \
    --data '{"model": "bedrock/anthropic.claude-3-haiku-20240307-v1:0","messages":[{"role": "user","content": "Hi!"}],"temperature": 0}'

# install aws v2 first
# aws bedrock-runtime converse --model-id anthropic.claude-3-haiku-20240307-v1:0 --messages '[{"role": "user", "content": [{"text": "Hi"}]}]'
