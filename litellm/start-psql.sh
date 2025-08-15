#!/usr/bin/env -S bash

set -xueo pipefail


docker exec -it postgres psql -U postgres