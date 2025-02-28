#!/usr/bin/env bash
set -euo pipefail

: "${PGHOST:?Set PGHOST}"
: "${PGPORT:?Set PGPORT}"
: "${PGUSER:?Set PGUSER}"
: "${PGPASSWORD:?Set PGPASSWORD}"
: "${PGDATABASE:?Set PGDATABASE}"

psql "$PGDATABASE" -v ON_ERROR_STOP=1 -f db/schema.sql
psql "$PGDATABASE" -v ON_ERROR_STOP=1 -f db/seed.sql
psql "$PGDATABASE" -v ON_ERROR_STOP=1 -f db/views.sql
psql "$PGDATABASE" -v ON_ERROR_STOP=1 -f tests/test.sql
