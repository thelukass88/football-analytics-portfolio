DROP TABLE IF EXISTS mart_team_plateaus;

CREATE TABLE mart_team_plateaus AS
WITH base AS (
  SELECT
    season,
    team_name,
    matchweek,
    match_date,
    points,
    CASE WHEN points <= 1 THEN 1 ELSE 0 END AS is_plateau_week
  FROM fact_match
),
marked AS (
  SELECT
    *,
    CASE
      WHEN is_plateau_week = 1
       AND COALESCE(LAG(is_plateau_week) OVER (PARTITION BY season, team_name ORDER BY matchweek), 0) = 0
      THEN 1 ELSE 0
    END AS run_start_flag
  FROM base
),
plateau_only AS (
  SELECT
    *,
    SUM(run_start_flag) OVER (PARTITION BY season, team_name ORDER BY matchweek) AS run_id
  FROM marked
  WHERE is_plateau_week = 1
),
agg AS (
  SELECT
    season,
    team_name,
    run_id,
    MIN(matchweek) AS start_matchweek,
    MAX(matchweek) AS end_matchweek,
    COUNT(*) AS plateau_weeks,
    MIN(match_date) AS start_date,
    MAX(match_date) AS end_date,
    SUM(points) AS points_during_plateau
  FROM plateau_only
  GROUP BY season, team_name, run_id
)
SELECT *
FROM agg
WHERE plateau_weeks >= 2;

