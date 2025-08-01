


export AWS_ACCESS_KEY_ID="$(cat $HOME/.aws/credentials | grep aws_access_key_id | awk -F= '{print $2}' | tr -d ' ')"  \
export AWS_SECRET_ACCESS_KEY="$(cat $HOME/.aws/credentials | grep aws_secret_access_key | awk -F= '{print $2}' | tr -d ' ')"


#-H "x-portkey-aws-session-token: IQoJ..." \



curl -v -s -X POST \
      http://localhost:8787/v1/chat/completions \
      -H 'x-portkey-config: {"cache":{"mode":"simple"}}' \
      -H "Content-Type: application/json" \
      -H "x-portkey-provider: bedrock" \
-H "x-portkey-aws-access-key-id: $AWS_ACCESS_KEY_ID" \
-H "x-portkey-aws-secret-access-key: $AWS_SECRET_ACCESS_KEY" \
-H "x-portkey-aws-region: eu-west-1" \
      -d '{
        "messages": [
            { "role": "user", "content": "Hi!" }
        ],
        "model": "anthropic.claude-3-haiku-20240307-v1:0",
        "temperature":0
      }' | yq -P 
