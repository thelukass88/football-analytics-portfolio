#!/usr/bin/env bash
set -euo pipefail

DB="football.db"

out="$(sqlite3 "$DB" < models/tests/001_data_checks.sql)"
echo "$out"

fail=0

# These should be exactly expected values
expect_exact () {
  local name="$1"
  local expected="$2"
  local actual
  actual="$(echo "$out" | awk -F'|' -v n="$name" '$1==n {print $2}' | tail -n 1)"
  if [[ "$actual" != "$expected" ]]; then
    echo "FAIL: $name expected $expected got ${actual:-<missing>}"
    fail=1
  fi
}

# These should be zero (e.g. unmatched keys, bad dates)
expect_zero () {
  local name="$1"
  local actual
  actual="$(echo "$out" | awk -F'|' -v n="$name" '$1==n {print $2}' | tail -n 1)"
  if [[ "$actual" != "0" ]]; then
    echo "FAIL: $name expected 0 got ${actual:-<missing>}"
    fail=1
  fi
}

expect_exact "stg_matches_count" "219"
expect_exact "mart_team_results_count" "438"
expect_exact "mart_league_table_teams" "20"

expect_zero "unmatched_odds_1x2"
expect_zero "null_match_id"
expect_zero "dates_outside_2025_2026"

if [[ "$fail" -eq 1 ]]; then
  exit 1
fi

echo "All tests passed."
