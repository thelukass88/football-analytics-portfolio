-- 001_create_staging_tables.sql
-- Creates staging tables from raw_matches in football.db
-- Run with: sqlite3 football.db < models/staging/001_create_staging_tables.sql

-- Notes:
-- - Source Date is dd/mm/yy. We also create match_date_iso (YYYY-MM-DD) for sorting and joining.
-- - match_id is a deterministic text key for joining staging tables.

-- =========================
-- stg_matches
-- =========================
DROP TABLE IF EXISTS stg_matches;

CREATE TABLE stg_matches AS
SELECT
  -- Core identifiers
  Div AS div,
  Date AS match_date_raw,
  ('20' || substr(Date, 7, 2) || '-' || substr(Date, 4, 2) || '-' || substr(Date, 1, 2)) AS match_date_iso,
  Time AS kickoff_time,
  HomeTeam AS home_team,
  AwayTeam AS away_team,

  -- Deterministic join key
  (Div || '_' ||
   ('20' || substr(Date, 7, 2) || substr(Date, 4, 2) || substr(Date, 1, 2)) || '_' ||
   replace(HomeTeam,' ','_') || '_vs_' || replace(AwayTeam,' ','_')
  ) AS match_id,

  -- Results
  CAST(FTHG AS INTEGER) AS home_goals_ft,
  CAST(FTAG AS INTEGER) AS away_goals_ft,
  FTR AS result_ft,
  CAST(HTHG AS INTEGER) AS home_goals_ht,
  CAST(HTAG AS INTEGER) AS away_goals_ht,
  HTR AS result_ht,

  -- Metadata
  Referee AS referee,

  -- Match stats
  CAST(HS  AS INTEGER) AS home_shots,
  CAST("AS"  AS INTEGER) AS away_shots,
  CAST(HST AS INTEGER) AS home_shots_on_target,
  CAST(AST AS INTEGER) AS away_shots_on_target,
  CAST(HF  AS INTEGER) AS home_fouls,
  CAST(AF  AS INTEGER) AS away_fouls,
  CAST(HC  AS INTEGER) AS home_corners,
  CAST(AC  AS INTEGER) AS away_corners,
  CAST(HY  AS INTEGER) AS home_yellow_cards,
  CAST(AY  AS INTEGER) AS away_yellow_cards,
  CAST(HR  AS INTEGER) AS home_red_cards,
  CAST(AR  AS INTEGER) AS away_red_cards
FROM raw_matches;

-- =========================
-- stg_odds_1x2 (Home/Draw/Away odds + market + exchange) - pre and closing
-- =========================
DROP TABLE IF EXISTS stg_odds_1x2;

CREATE TABLE stg_odds_1x2 AS
SELECT
  (Div || '_' ||
   ('20' || substr(Date, 7, 2) || substr(Date, 4, 2) || substr(Date, 1, 2)) || '_' ||
   replace(HomeTeam,' ','_') || '_vs_' || replace(AwayTeam,' ','_')
  ) AS match_id,

  -- Pre-closing bookmaker odds
  CAST(B365H AS REAL) AS b365_h,
  CAST(B365D AS REAL) AS b365_d,
  CAST(B365A AS REAL) AS b365_a,

  CAST(BFDH AS REAL) AS bfd_h,
  CAST(BFDD AS REAL) AS bfd_d,
  CAST(BFDA AS REAL) AS bfd_a,

  CAST(BMGMH AS REAL) AS bmgm_h,
  CAST(BMGMD AS REAL) AS bmgm_d,
  CAST(BMGMA AS REAL) AS bmgm_a,

  CAST(BVH AS REAL) AS bv_h,
  CAST(BVD AS REAL) AS bv_d,
  CAST(BVA AS REAL) AS bv_a,

  CAST(BWH AS REAL) AS bw_h,
  CAST(BWD AS REAL) AS bw_d,
  CAST(BWA AS REAL) AS bw_a,

  CAST(CLH AS REAL) AS cl_h,
  CAST(CLD AS REAL) AS cl_d,
  CAST(CLA AS REAL) AS cl_a,

  CAST(LBH AS REAL) AS lb_h,
  CAST(LBD AS REAL) AS lb_d,
  CAST(LBA AS REAL) AS lb_a,

  CAST(PSH AS REAL) AS ps_h,
  CAST(PSD AS REAL) AS ps_d,
  CAST(PSA AS REAL) AS ps_a,

  -- Market aggregates
  CAST(MaxH AS REAL) AS market_max_h,
  CAST(MaxD AS REAL) AS market_max_d,
  CAST(MaxA AS REAL) AS market_max_a,
  CAST(AvgH AS REAL) AS market_avg_h,
  CAST(AvgD AS REAL) AS market_avg_d,
  CAST(AvgA AS REAL) AS market_avg_a,

  -- Exchange
  CAST(BFEH AS REAL) AS bfe_h,
  CAST(BFED AS REAL) AS bfe_d,
  CAST(BFEA AS REAL) AS bfe_a,

  -- Closing bookmaker odds
  CAST(B365CH AS REAL) AS b365c_h,
  CAST(B365CD AS REAL) AS b365c_d,
  CAST(B365CA AS REAL) AS b365c_a,

  CAST(BFDCH AS REAL) AS bfdc_h,
  CAST(BFDCD AS REAL) AS bfdc_d,
  CAST(BFDCA AS REAL) AS bfdc_a,

  CAST(BMGMCH AS REAL) AS bmgmc_h,
  CAST(BMGMCD AS REAL) AS bmgmc_d,
  CAST(BMGMCA AS REAL) AS bmgmc_a,

  CAST(BVCH AS REAL) AS bvc_h,
  CAST(BVCD AS REAL) AS bvc_d,
  CAST(BVCA AS REAL) AS bvc_a,

  CAST(BWCH AS REAL) AS bwc_h,
  CAST(BWCD AS REAL) AS bwc_d,
  CAST(BWCA AS REAL) AS bwc_a,

  CAST(CLCH AS REAL) AS clc_h,
  CAST(CLCD AS REAL) AS clc_d,
  CAST(CLCA AS REAL) AS clc_a,

  CAST(LBCH AS REAL) AS lbc_h,
  CAST(LBCD AS REAL) AS lbc_d,
  CAST(LBCA AS REAL) AS lbc_a,

  CAST(PSCH AS REAL) AS psc_h,
  CAST(PSCD AS REAL) AS psc_d,
  CAST(PSCA AS REAL) AS psc_a,

  -- Closing market aggregates
  CAST(MaxCH AS REAL) AS market_maxc_h,
  CAST(MaxCD AS REAL) AS market_maxc_d,
  CAST(MaxCA AS REAL) AS market_maxc_a,
  CAST(AvgCH AS REAL) AS market_avgc_h,
  CAST(AvgCD AS REAL) AS market_avgc_d,
  CAST(AvgCA AS REAL) AS market_avgc_a,

  -- Closing exchange
  CAST(BFECH AS REAL) AS bfec_h,
  CAST(BFECD AS REAL) AS bfec_d,
  CAST(BFECA AS REAL) AS bfec_a

FROM raw_matches;

-- =========================
-- stg_odds_ou25 (Over/Under 2.5 goals) - pre and closing
-- =========================
DROP TABLE IF EXISTS stg_odds_ou25;

CREATE TABLE stg_odds_ou25 AS
SELECT
  (Div || '_' ||
   ('20' || substr(Date, 7, 2) || substr(Date, 4, 2) || substr(Date, 1, 2)) || '_' ||
   replace(HomeTeam,' ','_') || '_vs_' || replace(AwayTeam,' ','_')
  ) AS match_id,

  -- Pre-closing OU 2.5
  CAST("B365>2.5" AS REAL) AS b365_ou25_over,
  CAST("B365<2.5" AS REAL) AS b365_ou25_under,
  CAST("P>2.5"    AS REAL) AS p_ou25_over,
  CAST("P<2.5"    AS REAL) AS p_ou25_under,
  CAST("Max>2.5"  AS REAL) AS market_max_ou25_over,
  CAST("Max<2.5"  AS REAL) AS market_max_ou25_under,
  CAST("Avg>2.5"  AS REAL) AS market_avg_ou25_over,
  CAST("Avg<2.5"  AS REAL) AS market_avg_ou25_under,
  CAST("BFE>2.5"  AS REAL) AS bfe_ou25_over,
  CAST("BFE<2.5"  AS REAL) AS bfe_ou25_under,

  -- Closing OU 2.5
  CAST("B365C>2.5" AS REAL) AS b365c_ou25_over,
  CAST("B365C<2.5" AS REAL) AS b365c_ou25_under,
  CAST("PC>2.5"    AS REAL) AS pc_ou25_over,
  CAST("PC<2.5"    AS REAL) AS pc_ou25_under,
  CAST("MaxC>2.5"  AS REAL) AS market_maxc_ou25_over,
  CAST("MaxC<2.5"  AS REAL) AS market_maxc_ou25_under,
  CAST("AvgC>2.5"  AS REAL) AS market_avgc_ou25_over,
  CAST("AvgC<2.5"  AS REAL) AS market_avgc_ou25_under,
  CAST("BFEC>2.5"  AS REAL) AS bfec_ou25_over,
  CAST("BFEC<2.5"  AS REAL) AS bfec_ou25_under

FROM raw_matches;

-- =========================
-- stg_odds_ah (Asian handicap) - pre and closing
-- =========================
DROP TABLE IF EXISTS stg_odds_ah;

CREATE TABLE stg_odds_ah AS
SELECT
  (Div || '_' ||
   ('20' || substr(Date, 7, 2) || substr(Date, 4, 2) || substr(Date, 1, 2)) || '_' ||
   replace(HomeTeam,' ','_') || '_vs_' || replace(AwayTeam,' ','_')
  ) AS match_id,

  -- Pre-closing AH
  CAST(AHh     AS REAL) AS market_ah_handicap,
  CAST(B365AHH AS REAL) AS b365_ah_home_odds,
  CAST(B365AHA AS REAL) AS b365_ah_away_odds,
  CAST(PAHH    AS REAL) AS p_ah_home_odds,
  CAST(PAHA    AS REAL) AS p_ah_away_odds,
  CAST(MaxAHH  AS REAL) AS market_max_ah_home_odds,
  CAST(MaxAHA  AS REAL) AS market_max_ah_away_odds,
  CAST(AvgAHH  AS REAL) AS market_avg_ah_home_odds,
  CAST(AvgAHA  AS REAL) AS market_avg_ah_away_odds,
  CAST(BFEAHH  AS REAL) AS bfe_ah_home_odds,
  CAST(BFEAHA  AS REAL) AS bfe_ah_away_odds,

  -- Closing AH
  CAST(AHCh     AS REAL) AS market_ahc_handicap,
  CAST(B365CAHH AS REAL) AS b365c_ah_home_odds,
  CAST(B365CAHA AS REAL) AS b365c_ah_away_odds,
  CAST(PCAHH    AS REAL) AS pc_ah_home_odds,
  CAST(PCAHA    AS REAL) AS pc_ah_away_odds,
  CAST(MaxCAHH  AS REAL) AS market_maxc_ah_home_odds,
  CAST(MaxCAHA  AS REAL) AS market_maxc_ah_away_odds,
  CAST(AvgCAHH  AS REAL) AS market_avgc_ah_home_odds,
  CAST(AvgCAHA  AS REAL) AS market_avgc_ah_away_odds,
  CAST(BFECAHH  AS REAL) AS bfec_ah_home_odds,
  CAST(BFECAHA  AS REAL) AS bfec_ah_away_odds

FROM raw_matches;
