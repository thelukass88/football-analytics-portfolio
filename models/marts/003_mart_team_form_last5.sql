-- 003_mart_team_form_last5.sql
-- Team form over last 5 matches
-- Grain: one row per team
-- Run with: sqlite3 football.db < models/marts/003_mart_team_form_last5.sql

DROP TABLE IF EXISTS mart_team_form_last5;

CREATE TABLE mart_team_form_last5 AS
WITH ranked AS (
  SELECT
    team_id,
    team_name,
    match_id,
    match_date_iso,
    opponent_team_name,
    venue,
    goals_for,
    goals_against,
    result,
    points,
    ROW_NUMBER() OVER (
      PARTITION BY team_id
      ORDER BY match_date_iso DESC, match_id DESC
    ) AS rn
  FROM mart_team_results
),
last5 AS (
  SELECT *
  FROM ranked
  WHERE rn <= 5
),
agg AS (
  SELECT
    team_id,
    team_name,
    COUNT(*) AS matches_in_window,
    SUM(points) AS points_last5,
    SUM(CASE WHEN result='W' THEN 1 ELSE 0 END) AS wins_last5,
    SUM(CASE WHEN result='D' THEN 1 ELSE 0 END) AS draws_last5,
    SUM(CASE WHEN result='L' THEN 1 ELSE 0 END) AS losses_last5,
    SUM(goals_for) AS goals_for_last5,
    SUM(goals_against) AS goals_against_last5,
    SUM(goals_for) - SUM(goals_against) AS goal_diff_last5,
    MAX(match_date_iso) AS last_match_date
  FROM last5
  GROUP BY team_id, team_name
), form_string AS (
  SELECT DISTINCT
    team_id,
    team_name,
    FIRST_VALUE(match_date_iso) OVER (
      PARTITION BY team_id
      ORDER BY match_date_iso DESC, match_id DESC
    ) AS last_match_date,
    FIRST_VALUE(form_last5) OVER (
      PARTITION BY team_id
      ORDER BY match_date_iso DESC, match_id DESC
    ) AS form_last5
  FROM (
    SELECT
      team_id,
      team_name,
      match_id,
      match_date_iso,
      ROW_NUMBER() OVER (
        PARTITION BY team_id
        ORDER BY match_date_iso DESC, match_id DESC
      ) AS rn,
      GROUP_CONCAT(result, '-') OVER (
        PARTITION BY team_id
        ORDER BY match_date_iso DESC, match_id DESC
        ROWS BETWEEN CURRENT ROW AND 4 FOLLOWING
      ) AS form_last5
    FROM mart_team_results
  )
  WHERE rn = 1
)
SELECT
  a.team_id,
  a.team_name,
  a.matches_in_window,
  a.points_last5,
  a.wins_last5,
  a.draws_last5,
  a.losses_last5,
  a.goals_for_last5,
  a.goals_against_last5,
  a.goal_diff_last5,
  f.last_match_date,
  f.form_last5
FROM agg a
LEFT JOIN form_string f
  ON a.team_id = f.team_id;

