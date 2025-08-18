#!/usr/bin/env -S bash

set -ueo pipefail

out=/tmp/logs.json

curl -s 'http://localhost:4000/spend/logs/ui?start_date=2025-08-17+09%3A09%3A00&end_date=2025-08-18+09%3A12%3A43&page=1&page_size=50' \
  -H 'Accept: */*' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Accept-Encoding: gzip, deflate, br, zstd' \
  -H 'Referer: http://localhost:4000/ui/?login=success^&page=logs' \
  -H 'Authorization: Bearer sk-1234' \
  -H 'Content-Type: application/json' \
  -H 'Connection: keep-alive' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Priority: u=4' > $out


#yq .data[0].metadata.usage_object.completion_tokens -P $out
yq .data[0].completion_tokens -P $out
yq .data[0].startTime -P $out
yq .data[0].endTime -P $out

  
