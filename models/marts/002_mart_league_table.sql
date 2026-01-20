-- 002_mart_league_table.sql
-- Creates a league table mart from mart_team_results
-- Grain: one row per team (season-to-date)
-- Run with: sqlite3 football.db < models/marts/002_mart_league_table.sql

DROP TABLE IF EXISTS mart_league_table;

CREATE TABLE mart_league_table AS
SELECT
  team_id,
  team_name,

  COUNT(*) AS played,
  SUM(CASE WHEN result='W' THEN 1 ELSE 0 END) AS wins,
  SUM(CASE WHEN result='D' THEN 1 ELSE 0 END) AS draws,
  SUM(CASE WHEN result='L' THEN 1 ELSE 0 END) AS losses,

  SUM(goals_for) AS goals_for,
  SUM(goals_against) AS goals_against,
  SUM(goals_for) - SUM(goals_against) AS goal_difference,

  SUM(points) AS points,

  -- Useful “as-of” metadata
  MIN(match_date_iso) AS first_match_date,
  MAX(match_date_iso) AS last_match_date
FROM mart_team_results
GROUP BY team_id, team_name;
