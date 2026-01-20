-- Basic data checks (fail-fast style via returning counts)

-- Expect: 219 matches
SELECT 'stg_matches_count' AS check_name, COUNT(*) AS value FROM stg_matches;

-- Expect: 438 team-match rows
SELECT 'mart_team_results_count' AS check_name, COUNT(*) AS value FROM mart_team_results;

-- Expect: 20 teams
SELECT 'mart_league_table_teams' AS check_name, COUNT(*) AS value FROM mart_league_table;

-- Expect: no unmatched odds keys
SELECT 'unmatched_odds_1x2' AS check_name, COUNT(*) AS value
FROM stg_matches m
LEFT JOIN stg_odds_1x2 o USING(match_id)
WHERE o.match_id IS NULL;

-- Expect: no null match_id
SELECT 'null_match_id' AS check_name, COUNT(*) AS value
FROM stg_matches
WHERE match_id IS NULL;

-- Expect: all match dates are in 2025 or 2026 (guards against date parsing bugs)
SELECT
  'dates_outside_2025_2026' AS check_name,
  COUNT(*) AS value
FROM stg_matches
WHERE match_date_iso IS NULL
   OR substr(match_date_iso, 1, 4) NOT IN ('2025', '2026');

-- Optional: list a few offending rows (should return 0 rows)
SELECT
  match_id,
  match_date_raw,
  match_date_iso,
  home_team,
  away_team
FROM stg_matches
WHERE match_date_iso IS NULL
   OR substr(match_date_iso, 1, 4) NOT IN ('2025', '2026')
LIMIT 20;
