#!/usr/bin/env -S bash


aws bedrock-runtime converse --model-id anthropic.claude-3-haiku-20240307-v1:0 --messages '[{"role": "user", "content": [{"text": "Hi"}]}]'

aws bedrock-runtime converse --model-id anthropic.claude-3-haiku-20240307-v1:0 --messages '[{"role": "user", "content": [{"text": "Hi"}]}]'
