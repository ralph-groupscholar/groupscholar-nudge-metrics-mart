# GroupScholar Nudge Metrics Mart

A production-ready SQL mart for tracking scholar nudge activity, response rates, and action-item load across cohorts.

## Features
- Dedicated schema for outreach nudges, responses, and follow-up action items
- Analytics views for response rate, response latency, and action-item load
- Seed data for immediate reporting
- Simple production apply script with safety checks

## Tech
- SQL (PostgreSQL)

## Setup

Export production database environment variables:

```bash
export PGHOST=db-acupinir.groupscholar.com
export PGPORT=23947
export PGUSER=ralph
export PGPASSWORD='YOUR_PASSWORD'
export PGDATABASE=ralph
```

Apply schema, seed data, and views in production:

```bash
./scripts/apply-prod.sh
```

## Testing

```bash
psql "$PGDATABASE" -v ON_ERROR_STOP=1 -f tests/test.sql
```

## Schema notes
- All tables live under the `groupscholar_nudge_metrics_mart` schema.
- Use the provided views for response rate, latency, and action-item load.
