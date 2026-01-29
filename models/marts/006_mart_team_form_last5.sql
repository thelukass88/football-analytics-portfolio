DROP TABLE IF EXISTS mart_team_form_last5;

CREATE TABLE mart_team_form_last5 AS
WITH ranked AS (
  SELECT
    season,
    team_name,
    matchweek,
    match_date,
    result,
    points,
    ROW_NUMBER() OVER (
      PARTITION BY season, team_name
      ORDER BY matchweek DESC
    ) AS rn_desc
  FROM fact_match
),
last5 AS (
  SELECT *
  FROM ranked
  WHERE rn_desc <= 5
),
agg AS (
  SELECT
    season,
    team_name,
    COUNT(*) AS matches_in_window,
    SUM(points) AS points_last5,
    SUM(CASE WHEN result='W' THEN 1 ELSE 0 END) AS wins_last5,
    SUM(CASE WHEN result='D' THEN 1 ELSE 0 END) AS draws_last5,
    SUM(CASE WHEN result='L' THEN 1 ELSE 0 END) AS losses_last5,
    MIN(match_date) AS window_start_date,
    MAX(match_date) AS window_end_date
  FROM last5
  GROUP BY season, team_name
)
SELECT * FROM agg;

