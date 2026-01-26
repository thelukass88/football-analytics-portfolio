DROP TABLE IF EXISTS fact_match;

CREATE TABLE fact_match AS
WITH match_rows AS (
  -- Home team perspective
  SELECT
    season,
    match_date,
    division,
    home_team AS team_name,
    away_team AS opponent_name,
    1 AS is_home,

    home_goals_ft AS goals_for,
    away_goals_ft AS goals_against,

    home_shots AS shots_for,
    away_shots AS shots_against,
    home_shots_on_target AS shots_on_target_for,
    away_shots_on_target AS shots_on_target_against,

    home_corners AS corners_for,
    away_corners AS corners_against,

    home_fouls AS fouls_for,
    away_fouls AS fouls_against,

    home_yellow_cards AS yellow_cards_for,
    away_yellow_cards AS yellow_cards_against,
    home_red_cards AS red_cards_for,
    away_red_cards AS red_cards_against,

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

  FROM stg_matches

  UNION ALL

  -- Away team perspective
  SELECT
    season,
    match_date,
    division,
    away_team AS team_name,
    home_team AS opponent_name,
    0 AS is_home,

    away_goals_ft AS goals_for,
    home_goals_ft AS goals_against,

    away_shots AS shots_for,
    home_shots AS shots_against,
    away_shots_on_target AS shots_on_target_for,
    home_shots_on_target AS shots_on_target_against,

    away_corners AS corners_for,
    home_corners AS corners_against,

    away_fouls AS fouls_for,
    home_fouls AS fouls_against,

    away_yellow_cards AS yellow_cards_for,
    home_yellow_cards AS yellow_cards_against,
    away_red_cards AS red_cards_for,
    home_red_cards AS red_cards_against,

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

  FROM stg_matches
),
numbered AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY season, team_name
      ORDER BY match_date, is_home DESC, opponent_name
    ) AS matchweek
  FROM match_rows
)
SELECT * FROM numbered;


