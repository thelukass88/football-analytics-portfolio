-- 001_create_core_models.sql
-- Creates core tables from staging tables
-- Run with: sqlite3 football.db < models/core/001_create_core_models.sql

-- =========================
-- dim_team
-- =========================
DROP TABLE IF EXISTS dim_team;

CREATE TABLE dim_team AS
WITH teams AS (
  SELECT home_team AS team_name FROM stg_matches
  UNION
  SELECT away_team AS team_name FROM stg_matches
)
SELECT
  lower(replace(team_name, ' ', '_')) AS team_id,
  team_name
FROM teams
ORDER BY team_name;

-- =========================
-- fact_match
-- Grain: one row per match_id
-- =========================
DROP TABLE IF EXISTS fact_match;

CREATE TABLE fact_match AS
SELECT
  m.match_id,
  m.div,
  m.match_date_iso,
  m.kickoff_time,

  lower(replace(m.home_team, ' ', '_')) AS home_team_id,
  m.home_team AS home_team_name,
  lower(replace(m.away_team, ' ', '_')) AS away_team_id,
  m.away_team AS away_team_name,

  m.home_goals_ft,
  m.away_goals_ft,
  m.result_ft,
  m.home_goals_ht,
  m.away_goals_ht,
  m.result_ht,

  m.referee,
  m.home_shots,
  m.away_shots,
  m.home_shots_on_target,
  m.away_shots_on_target,
  m.home_fouls,
  m.away_fouls,
  m.home_corners,
  m.away_corners,
  m.home_yellow_cards,
  m.away_yellow_cards,
  m.home_red_cards,
  m.away_red_cards
FROM stg_matches m;

-- Helpful indexes
DROP INDEX IF EXISTS idx_fact_match_date;
CREATE INDEX idx_fact_match_date ON fact_match(match_date_iso);

DROP INDEX IF EXISTS idx_fact_match_home_team;
CREATE INDEX idx_fact_match_home_team ON fact_match(home_team_id);

DROP INDEX IF EXISTS idx_fact_match_away_team;
CREATE INDEX idx_fact_match_away_team ON fact_match(away_team_id);
