# Football Analytics Portfolio (Analytics Engineering)

This project builds an analytics-ready dataset from public football match CSVs and models it into clean tables suitable for BI (e.g., Power BI).

## Goals
- Ingest public match data (CSV)
- Standardise and clean fields (staging)
- Build core analytical tables (facts/dimensions)
- Produce reporting-ready metrics (marts)

## Data source
Public CSV match data from football-data.co.uk.

## Repo structure
- `data/raw/` raw CSVs (source data)
- `models/` SQL models (staging/core/marts)
- `docs/` notes, assumptions, data dictionary
- `scripts/` helper scripts (download/convert/load)

## Status
Version 1: repo skeleton and initial data ingestion.

## Local database

This project uses a local SQLite database (`football.db`) for development.
The database file is intentionally excluded from version control.

To recreate the database locally:

1. Place raw CSVs in `data/raw/`
2. Import CSVs into SQLite
3. Run SQL scripts in `models/staging/` and `models/core/`

**Premier League Performance (Season-to-date)**

## Overview
This project demonstrates an end-to-end **analytics engineering workflow** using real football match data.  
Raw CSV data is transformed through structured SQL layers into analytics-ready marts, which are then visualised in Tableau as a thin presentation layer.

The focus is on:
- clear metric definitions
- reproducible transformations
- data quality checks
- BI-ready outputs

---

## Data Source
- Public Premier League match data (`E0.csv`)
- Includes results, match statistics, and bookmaker odds

Raw data is treated as **immutable** and is never edited directly.

---

## Architecture
Raw CSV
↓
Staging (cleaning, typing, keys)
↓
Core models (facts & dimensions)
↓
Analytics marts (decision-ready tables)
↓
CSV exports
↓
Tableau dashboard


### Layers

**Raw**
- `raw_matches`

**Staging**
- `stg_matches`
- `stg_odds_1x2`
- `stg_odds_ou25`
- `stg_odds_ah`

**Core**
- `fact_match` — one row per match
- `dim_team` — one row per team

**Marts**
- `mart_team_results` — one row per team per match
- `mart_league_table` — current league standings
- `mart_team_form_last5` — rolling last-5 match form
- `mart_team_points_cumulative` — cumulative points over time

All business logic (points, form, ordering) is implemented in SQL, not in the BI tool.

---

## Reproducibility

### Build everything from scratch
```bash
./scripts/build_all.sh
