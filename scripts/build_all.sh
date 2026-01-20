#!/usr/bin/env bash
set -euo pipefail

DB="football.db"

# Build order
sqlite3 "$DB" < models/staging/001_create_staging_tables.sql
sqlite3 "$DB" < models/core/001_create_core_models.sql
sqlite3 "$DB" < models/marts/001_mart_team_results.sql
sqlite3 "$DB" < models/marts/002_mart_league_table.sql
sqlite3 "$DB" < models/marts/003_mart_team_form_last5.sql

echo "Build complete."
