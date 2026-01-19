# Data Dictionary — Premier League (E0.csv)

## Source documentation

Official column definitions and abbreviations are provided by the data source and preserved verbatim in:

`docs/source_notes/football-data-notes.txt`

This dictionary maps raw source columns to analytics-friendly names used in this project.

## File metadata

- League: Premier League
- Season: Current season
- Source file: E0.csv
- Grain: One row per match

## Column mapping (initial)

| Source Column | Analytics Column | Description |
|--------------|-----------------|-------------|
| Date | match_date | Match date |
| HomeTeam | home_team | Home team name |
| AwayTeam | away_team | Away team name |
| FTHG | home_goals | Full-time home goals |
| FTAG | away_goals | Full-time away goals |
| FTR | full_time_result | Match result (H/D/A) |
