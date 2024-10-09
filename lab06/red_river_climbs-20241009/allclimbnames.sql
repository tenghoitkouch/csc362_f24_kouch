USE red_river_climbs;

SELECT  climb_name, crag_name
FROM    climbs
        INNER JOIN crags
        USING (crag_id);
