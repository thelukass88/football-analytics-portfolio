DROP TABLE IF EXISTS mart_team_points_cumulative;

CREATE TABLE mart_team_points_cumulative AS
WITH base AS (
  SELECT
    season,
    team_name,
    matchweek,
    match_date,
    points
  FROM fact_match
),
calc AS (
  SELECT
    season,
    team_name,
    matchweek,
    match_date,
    points,
    SUM(points) OVER (
      PARTITION BY season, team_name
      ORDER BY matchweek
    ) AS cumulative_points
  FROM base
)
SELECT * FROM calc;


