DROP TABLE IF EXISTS stg_matches;

CREATE TABLE stg_matches AS
SELECT
  season,

    -- Parse Date reliably from either dd/mm/yy or dd/mm/yyyy
  CASE
    WHEN LENGTH(TRIM(Date)) = 8 THEN DATE(
      '20' || SUBSTR(TRIM(Date), 7, 2) || '-' ||
      SUBSTR(TRIM(Date), 4, 2) || '-' ||
      SUBSTR(TRIM(Date), 1, 2)
    )
    WHEN LENGTH(TRIM(Date)) = 10 THEN DATE(
      SUBSTR(TRIM(Date), 7, 4) || '-' ||
      SUBSTR(TRIM(Date), 4, 2) || '-' ||
      SUBSTR(TRIM(Date), 1, 2)
    )
    ELSE NULL
  END AS match_date,

  Div AS division,
  HomeTeam AS home_team,
  AwayTeam AS away_team,

  CAST(FTHG AS INTEGER) AS home_goals_ft,
  CAST(FTAG AS INTEGER) AS away_goals_ft,
  FTR AS full_time_result,

  CAST(HTHG AS INTEGER) AS home_goals_ht,
  CAST(HTAG AS INTEGER) AS away_goals_ht,
  HTR AS half_time_result,

  Referee AS referee,

  CAST(HS AS INTEGER)  AS home_shots,
  CAST("AS" AS INTEGER) AS away_shots,
  CAST(HST AS INTEGER) AS home_shots_on_target,
  CAST(AST AS INTEGER) AS away_shots_on_target,

  CAST(HF AS INTEGER) AS home_fouls,
  CAST(AF AS INTEGER) AS away_fouls,
  CAST(HC AS INTEGER) AS home_corners,
  CAST(AC AS INTEGER) AS away_corners,

  CAST(HY AS INTEGER) AS home_yellow_cards,
  CAST(AY AS INTEGER) AS away_yellow_cards,
  CAST(HR AS INTEGER) AS home_red_cards,
  CAST(AR AS INTEGER) AS away_red_cards

FROM raw_matches;

