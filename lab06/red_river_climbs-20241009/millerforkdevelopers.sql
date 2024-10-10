USE red_river_climbs;

SELECT  climber_first_name, climber_last_name
FROM    climber_climbs_established
        INNER JOIN climbers
        USING (climber_id)
        INNER JOIN climbs
        USING (climb_id)
        INNER JOIN crags
        USING (crag_id)
        INNER JOIN regions
        USING (region_id)
WHERE   region_name = 'Miller Fork'
GROUP BY(climber_id);