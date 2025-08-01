#!/usr/bin/env -S bash

time curl -s "http://localhost:${LITELLM_PORT:-4000}/chat/completions" \
    --header "Authorization: Bearer ${LITELLM_MASTER_KEY:-sk-1234}" \
    --header "Content-Type: application/json" \
    --data '{
      "model": "bedrock/eu.amazon.nova-lite-v1:0",
      "messages":[
        {"role": "user","content": "Calculate 1+2"}
      ],
      "tools": [
        {
          "type": "function",
          "function": {
            "name": "calculator",
            "description": "calculations of mathematical expressions",
            "parameters": {
              "type": "object",
              "properties": {
                "expression": {
                  "type": "string",
                  "description": "mathematical expression to process"
                }
              },
              "required": ["expression"]
            }
          }
        }
      ],
      "temperature": 0,
      "tool_choice": "asdf",
      "drop_params":true
    }' | yq -P 
