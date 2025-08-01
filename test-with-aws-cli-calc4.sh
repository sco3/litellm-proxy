#!/usr/bin/env -S bash

set -xueo pipefail

time aws bedrock-runtime converse --debug \
   --model-id eu.amazon.nova-lite-v1:0 \
   --messages '[{"role": "user", "content": [{"text": "calculate 2*2"}]}]' \
   --inference-config '{"temperature": 0}'  \
   --tool-config '
{
  "toolChoice": {
"tool": { "name" : "sum_calc"}
  },
  "tools": [
    {
      "toolSpec": {
        "name": "sum_calc",
        "description": "API to calculate sum of numbers",
        "inputSchema": {
          "json": {
            "type": "object",
            "properties": {
              "expression": {
                "type": "string",
                "description": "Mathematical expression to evaluate"
              }
            },
            "required": [
              "expression"
            ]
          }
        }
      }
    },
    {
      "toolSpec": {
        "name": "mul_calc",
        "description": "API to calculate multiplications",
        "inputSchema": {
          "json": {
            "type": "object",
            "properties": {
              "expression": {
                "type": "string",
                "description": "Mathematical expression to evaluate"
              }
            },
            "required": [
              "expression"
            ]
          }
        }
      }
    }
  ]
}
'

