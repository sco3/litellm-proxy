docker rm -f portkey-gateway

docker run \
    --name=portkey-gateway \
    --network=bridge \
    --workdir=/app \
    -p 8787:8787 \
    --detach=true \
    portkeyai/gateway:latest