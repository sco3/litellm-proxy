#!/usr/bin/env -S bash

set -xueo pipefail

time aws bedrock-runtime converse \
   --model-id eu.amazon.nova-lite-v1:0 \
   --messages '[{"role": "user", "content": [{"text": "Hi"}]}]' \
   --inference-config '{"temperature": 0, "tool_choice":"required"}'
