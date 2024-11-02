-- Write a sequence of SQL statements which will remove all routes from the database which were equipped in in 2010, or more recently

USE red_river_climbs;

-- restrict rule in place so have del from subset tbl first

SELECT * 
FROM sport_climbs
    JOIN climbs
    USING (climb_id);

DELETE sc
FROM sport_climbs AS sc
    JOIN climbs AS c
    USING (climb_id)
WHERE c.climb_established_date >= '2010-01-01';

SELECT * 
FROM sport_climbs
    JOIN climbs
    USING (climb_id);



-- SELECT * 
-- FROM trad_climbs;

-- DELETE FROM trad_climbs
-- WHERE climb_id IN (
--     SELECT climb_id
--     FROM climbs
--     WHERE climb_established_date >= '2010-01-01';
-- )

-- SELECT * 
-- FROM trad_climbs;



-- SELECT * 
-- FROM climbs;

-- DELETE FROM climbs
-- WHERE climb_established_date >= '2010-01-01';

-- SELECT * 
-- FROM climbs;