DROP TABLE IF EXISTS mart_team_plateau_weeks;

CREATE TABLE mart_team_plateau_weeks AS
SELECT
  season,
  team_name,
  matchweek,
  match_date,
  points,
  CASE WHEN points <= 1 THEN 1 ELSE 0 END AS is_plateau_week
FROM fact_match;

