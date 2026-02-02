DROP TABLE IF EXISTS mart_champions_trajectory;

CREATE TABLE mart_champions_trajectory AS
WITH top_two AS (
    SELECT
        season,
        team_name,
        league_position
    FROM mart_league_table
    WHERE league_position IN (1, 2)
),

champion_trajectories AS (
    SELECT
        c.season,
        c.team_name,
        c.matchweek,
        c.cumulative_points,
        t.league_position,
        CASE
            WHEN t.league_position = 1 THEN 'Champion'
            ELSE 'Runner-up'
        END AS finish_type
    FROM mart_team_points_cumulative c
    JOIN top_two t
        ON c.season = t.season
       AND c.team_name = t.team_name
)

SELECT *
FROM champion_trajectories
ORDER BY season, league_position, matchweek;

