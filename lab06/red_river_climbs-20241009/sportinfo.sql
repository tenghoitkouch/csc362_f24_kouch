USE red_river_climbs;

SELECT  climb_name, sport_climb_bolts, GROUP_CONCAT(climber_forum_handle)
FROM    sport_climbs
        INNER JOIN climbs
        USING (climb_id)
        INNER JOIN climber_first_ascents
        USING (climb_id)
        INNER JOIN climbers
        USING (climber_id)
GROUP BY (climb_name);