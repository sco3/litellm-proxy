#!/usr/bin/env -S bash

set -ueo pipefail

out=/tmp/logs.json
cook=/tmp/cook.bin

rm $cook || echo no cookie file for now 

curl -s 'http://localhost:4000/login' \
  -X POST \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Accept-Encoding: gzip, deflate, br, zstd' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Origin: http://localhost:4000' \
  -H 'Connection: keep-alive' \
  -H 'Referer: http://localhost:4000/sso/key/generate' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Priority: u=0, i' \
  --cookie-jar $cook \
  --data-raw 'username=admin&password=sk-1234'

key=$(grep token $cook | awk '{ print $7}'  |  awk -F'.' '{ print $2 }' | base64 --decode | yq .key)

curl -s 'http://localhost:4000/spend/logs/ui?start_date=2025-08-17+12%3A01%3A00&end_date=2025-08-18+12%3A01%3A35&page=1&page_size=50' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:141.0) Gecko/20100101 Firefox/141.0' \
  -H 'Accept: */*' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Accept-Encoding: gzip, deflate, br, zstd' \
  -H 'Referer: http://localhost:4000/ui/?login=success^&page=logs' \
  -H 'Content-Type: application/json' \
  -H 'Connection: keep-alive' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Priority: u=0' --cookie-jar $cook \
  -H "Authorization: Bearer $key" \
  > $out

#yq .data[0].metadata.usage_object.completion_tokens -P $out

yq .data[0].completion_tokens -P $out
yq .data[0].startTime -P $out
yq .data[0].endTime -P $out

  
