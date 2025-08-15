#!/usr/bin/env -S bash

set -xueo pipefail

docker exec -it postgres psql -U postgres -c "
SELECT 
    model,
    \"startTime\",
    completion_tokens, 
    completion_tokens/EXTRACT(EPOCH FROM (\"endTime\" - \"startTime\")) as tps
FROM \"LiteLLM_SpendLogs\"
WHERE status = 'success' order by model, \"startTime\"; "