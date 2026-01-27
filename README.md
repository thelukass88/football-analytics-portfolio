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

---

## Analytical Insights

Exploratory analysis and commentary based on the analytics marts can be found here:

- [`docs/insights.md`](docs/insights.md)

This includes:
- comparison of league position vs recent form
- identification of potential regression risks
- discussion of the predictive value of rolling form windows

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

---

## Data Model & Pipeline

This project is structured using a layered analytics-engineering approach to support clean, reproducible analysis across multiple Premier League seasons.

### Raw Layer
- Source data consists of season-level CSV files from football-data.co.uk (e.g. `E_2324.csv`, `E_2425.csv`, `E_2526.csv`)
- Raw files are ingested into SQLite with minimal transformation
- A unified `raw_matches` table is created, with an explicit `season` column to support multi-season analysis
- Only stable, match-level columns are included at this stage to guard against schema drift between seasons

### Staging Layer (`stg_matches`)
- Cleans and standardises raw data:
  - parses match dates into ISO format
  - renames ambiguous or problematic column names
  - casts numeric fields to appropriate types
- Preserves the `season` dimension for all downstream models
- Acts as the single, trusted source for core modelling

### Core Layer (`fact_match`)
- Transforms match-level data into a team-level fact table
- Each match produces two rows:
  - one from the home team perspective
  - one from the away team perspective
- Calculates:
  - goals for / against
  - match result
  - points earned
- Adds a `matchweek` index per team per season using window functions
- This structure enables cumulative metrics, rolling windows, and trajectory analysis

### Marts
- Analytics-ready tables built from `fact_match`
- Current marts include:
  - cumulative points by team, season, and matchweek
- These marts are designed for direct consumption by BI tools such as Tableau

---

## Analytical Focus

The primary analytical goal of this project is to examine team performance trajectories across seasons, including:

- how cumulative points evolve over the course of a season
- whether teams experience consistent plateau periods
- whether those plateaus occur at similar phases across different seasons

This structure enables longitudinal comparison while keeping business logic out of the BI layer.

