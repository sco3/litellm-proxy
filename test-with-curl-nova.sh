#!/usr/bin/env -S bash



time curl -s "http://localhost:${LITELLM_PORT:-4000}/chat/completions" \
    --header "Authorization: Bearer ${LITELLM_MASTER_KEY:-sk-1234}" \
    --header "Content-Type: application/json" \
    --data '
    {
      "model": "bedrock/eu.amazon.nova-lite-v1:0",
      "messages":[
        {"role": "user","content": "Can you calculate 1+2 ?"}
      ],
      "functions": [
                    {
                        "name": "calculator",
                        "description": "calculations of mathematical expressions",
                        "parameters": {
                            "type": "object",
                            "properties": {
                                "expression": {
                                    "type": "string",
                                    "description": "mathematical expression to process"
                                }
                            }
                        }
                    }
                ],
      "temperature": 0,
      "toolChoice":{"any":{}},
      "drop_params":true
    }' | yq -P 

