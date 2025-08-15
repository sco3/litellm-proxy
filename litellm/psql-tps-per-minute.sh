#!/usr/bin/env -S bash

set -xueo pipefail

docker exec -it postgres psql -U postgres -c "
SELECT
    DATE_TRUNC('minute', \"startTime\") AS minute,
    AVG(completion_tokens / EXTRACT(EPOCH FROM (\"endTime\" - \"startTime\"))) AS avg_tps
FROM \"LiteLLM_SpendLogs\"
WHERE status = 'success'
GROUP BY minute
ORDER BY minute 
"
