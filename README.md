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
