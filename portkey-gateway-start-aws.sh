docker rm -f portkey-gateway



export AWS_ACCESS_KEY_ID="$(cat $HOME/.aws/credentials | grep aws_access_key_id | awk -F= '{print $2}' | tr -d ' ')"  \
export AWS_SECRET_ACCESS_KEY="$(cat $HOME/.aws/credentials | grep aws_secret_access_key | awk -F= '{print $2}' | tr -d ' ')"

set | grep AWS

cp bedrock-config.json /tmp/config.json

echo ok

yq -i '.providers.bedrock.access_key_id = strenv(AWS_ACCESS_KEY_ID)' /tmp/config.json
yq -i '.providers.bedrock.secret_access_key = strenv(AWS_SECRET_ACCESS_KEY)' /tmp/config.json

 docker run \
    -v ~/.aws:/root/.aws:ro \
    -v /tmp/config.json:/tmp/config.json \
    -e AWS_ASSUME_ROLE_ACCESS_KEY_ID="$(cat $HOME/.aws/credentials | grep aws_access_key_id | awk -F= '{print $2}' | tr -d ' ')"  \
    -e AWS_ASSUME_ROLE_SECRET_ACCESS_KEY="$(cat $HOME/.aws/credentials | grep aws_secret_access_key | awk -F= '{print $2}' | tr -d ' ')"  \
    -e AWS_REGION=us-east-1 \
    --name=portkey-gateway \
    --network=bridge \
    --workdir=/app \
    -p 8787:8787 \
    --detach=true \
    portkeyai/gateway:latest 