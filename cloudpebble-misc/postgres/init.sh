#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

psql -U postgres -c "ALTER SYSTEM SET max_connections = '500';"
psql -U postgres -c "ALTER SYSTEM SET shared_buffers = '512KB';"
psql -U postgres -c "ALTER SYSTEM SET effective_cache_size = '1GB';"
psql -U postgres -c "ALTER SYSTEM SET maintenance_work_mem = '512MB';"
psql -U postgres -c "ALTER SYSTEM SET checkpoint_completion_target = '0.8';"
psql -U postgres -c "ALTER SYSTEM SET wal_buffers = '8MB';"
psql -U postgres -c "ALTER SYSTEM SET default_statistics_target = '100';"
psql -U postgres -c "ALTER SYSTEM SET random_page_cost = '1.1';"
psql -U postgres -c "ALTER SYSTEM SET effective_io_concurrency = '200';"
psql -U postgres -c "ALTER SYSTEM SET work_mem = '32MB';"
psql -U postgres -c "ALTER SYSTEM SET min_wal_size = '1GB';"
psql -U postgres -c "ALTER SYSTEM SET max_wal_size = '2GB';"
psql -U postgres -c "ALTER SYSTEM SET max_worker_processes = '32';"
psql -U postgres -c "ALTER SYSTEM SET max_parallel_workers_per_gather = '6';"
psql -U postgres -c "ALTER SYSTEM SET max_parallel_workers = '12';"
psql -U postgres -c "ALTER SYSTEM SET online_analyze.enable = off;"
psql -U postgres -c "ALTER SYSTEM SET select pg_reload_conf()"

