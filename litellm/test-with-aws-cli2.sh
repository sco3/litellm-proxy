#!/usr/bin/env -S bash

set -xueo pipefail

time aws bedrock-runtime converse --debug \
   --model-id anthropic.claude-3-haiku-20240307-v1:0 \
   --messages '[{"role": "user", "content": [{"text": "Hi"}]}]' \
   --inference-config '{"temperature": 0}'  \
   --tool-config '
{
  "toolChoice": {
    "any": {}
  },
  "tools": [
    {
      "toolSpec": {
        "name": "get_products_by_id",
        "description": "API to retrieve retail products based on search criteria",
        "inputSchema": {
          "json": {
            "type": "object",
            "properties": {
              "product_id": {
                "type": "string",
                "description": "Unique identifier of the product"
              }
            },
            "required": [
              "product_id"
            ]
          }
        }
      }
    }
  ]
}
'

