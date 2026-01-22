# Insights (Premier League, E0.csv)

This section is generated from the marts built in this repo:

- `mart_league_table` (season-to-date standings)
- `mart_team_form_last5` (rolling last-5 match form)

> Notes: “Form” is calculated from the last 5 matches per team by `match_date_iso` (newest first).

## Current Top 5 (season-to-date)

Arsenal|22|15|5|2|40|14|26|50|2026-01-17
Man City|22|13|4|5|45|21|24|43|2026-01-17
Aston Villa|22|13|4|5|33|25|8|43|2026-01-18
Liverpool|22|10|6|6|33|29|4|36|2026-01-17
Man United|22|9|8|5|38|32|6|35|2026-01-17

## Best last-5 form (top 5)

Arsenal|5|11|3|2|0|5|D-D-W-W-W|2026-01-17
Brentford|5|10|3|1|1|6|L-W-W-D-W|2026-01-17
Newcastle|5|10|3|1|1|4|D-W-W-W-L|2026-01-18
Man United|5|9|2|3|0|3|W-D-D-D-W|2026-01-17
Everton|5|8|2|2|1|1|W-D-L-W-D|2026-01-18

## Biggest goal difference (top 5)

Arsenal|22|40|14|26|50
Man City|22|45|21|24|43
Chelsea|22|36|24|12|34
Aston Villa|22|33|25|8|43
Man United|22|38|32|6|35

## Home vs Away (league-wide)

1.62100456621005|1.11415525114155|0.506849315068493

## Among the current Top 5, who has the worst last-5 form?

Man City|43|6|L-D-D-D-W|-1|2026-01-17

---

## League Position vs Recent Form

**Question**  
Do the teams currently at the top of the league also show strong recent momentum?

**Data Used**  
- `mart_league_table`
- `mart_team_form_last5`

**Query**
```sql
SELECT
  lt.team_name,
  lt.points AS season_points,
  f.points_last5
FROM mart_league_table lt
JOIN mart_team_form_last5 f
  ON lt.team_name = f.team_name
ORDER BY lt.points DESC
LIMIT 5;

It's evident that the form data cross reference with the league table indicates that some teams are unlikely to remain in the Top 5 with the trend of their current form. 

Future question: determine how much the last 5 games is an indication of the trajectory of a team (use previous season data or retrospectively look back at league position to determine if any 5 games can act as indicative of trajectory)

