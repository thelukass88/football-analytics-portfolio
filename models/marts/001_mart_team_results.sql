-- 001_mart_team_results.sql
-- Creates a team-per-match mart from fact_match
-- Grain: one row per team per match
-- Run with: sqlite3 football.db < models/marts/001_mart_team_results.sql

DROP TABLE IF EXISTS mart_team_results;

CREATE TABLE mart_team_results AS
-- Home team rows
SELECT
  match_id,
  div,
  match_date_iso,
  kickoff_time,

  home_team_id AS team_id,
  home_team_name AS team_name,
  away_team_id AS opponent_team_id,
  away_team_name AS opponent_team_name,

  'home' AS venue,

  home_goals_ft AS goals_for,
  away_goals_ft AS goals_against,

  CASE
    WHEN home_goals_ft > away_goals_ft THEN 'W'
    WHEN home_goals_ft = away_goals_ft THEN 'D'
    ELSE 'L'
  END AS result,

  CASE
    WHEN home_goals_ft > away_goals_ft THEN 3
    WHEN home_goals_ft = away_goals_ft THEN 1
    ELSE 0
  END AS points
FROM fact_match

UNION ALL

-- Away team rows
SELECT
  match_id,
  div,
  match_date_iso,
  kickoff_time,

  away_team_id AS team_id,
  away_team_name AS team_name,
  home_team_id AS opponent_team_id,
  home_team_name AS opponent_team_name,

  'away' AS venue,

  away_goals_ft AS goals_for,
  home_goals_ft AS goals_against,

  CASE
    WHEN away_goals_ft > home_goals_ft THEN 'W'
    WHEN away_goals_ft = home_goals_ft THEN 'D'
    ELSE 'L'
  END AS result,

  CASE
    WHEN away_goals_ft > home_goals_ft THEN 3
    WHEN away_goals_ft = home_goals_ft THEN 1
    ELSE 0
  END AS points
FROM fact_match;

-- Helpful indexes
DROP INDEX IF EXISTS idx_mart_team_results_team_date;
CREATE INDEX idx_mart_team_results_team_date
ON mart_team_results(team_id, match_date_iso);
