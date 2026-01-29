DROP TABLE IF EXISTS mart_league_table;

CREATE TABLE mart_league_table AS
WITH team_season_totals AS (
  SELECT
    season,
    team_name,
    COUNT(*) AS matches_played,
    SUM(points) AS points,
    SUM(goals_for) AS goals_for,
    SUM(goals_against) AS goals_against,
    SUM(goals_for) - SUM(goals_against) AS goal_difference,
    SUM(CASE WHEN result = 'W' THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN result = 'D' THEN 1 ELSE 0 END) AS draws,
    SUM(CASE WHEN result = 'L' THEN 1 ELSE 0 END) AS losses
  FROM fact_match
  GROUP BY season, team_name
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY season
      ORDER BY points DESC, goal_difference DESC, goals_for DESC, team_name ASC
    ) AS league_position
  FROM team_season_totals
)
SELECT * FROM ranked;

DROP TABLE IF EXISTS mart_league_table;

CREATE TABLE mart_league_table AS
WITH team_season_totals AS (
  SELECT
    season,
    team_name,
    COUNT(*) AS matches_played,
    SUM(points) AS points,
    SUM(goals_for) AS goals_for,
    SUM(goals_against) AS goals_against,
    SUM(goals_for) - SUM(goals_against) AS goal_difference,
    SUM(CASE WHEN result = 'W' THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN result = 'D' THEN 1 ELSE 0 END) AS draws,
    SUM(CASE WHEN result = 'L' THEN 1 ELSE 0 END) AS losses
  FROM fact_match
  GROUP BY season, team_name
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY season
      ORDER BY points DESC, goal_difference DESC, goals_for DESC, team_name ASC
    ) AS league_position
  FROM team_season_totals
)
SELECT * FROM ranked;

