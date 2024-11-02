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



SELECT * 
FROM trad_climbs
    JOIN climbs
    USING (climb_id);

DELETE tc
FROM trad_climbs AS tc
    JOIN climbs AS c
    USING (climb_id)
WHERE c.climb_established_date >= '2010-01-01';

SELECT * 
FROM trad_climbs
    JOIN climbs
    USING (climb_id);



--need to del from climber_established and first ascents too :/
SELECT * 
FROM climber_climbs_established
    JOIN climbs
    USING (climb_id);

DELETE cce
FROM climber_climbs_established AS cce
    JOIN climbs AS c
    USING (climb_id)
WHERE c.climb_established_date >= '2010-01-01';

SELECT * 
FROM climber_climbs_established
    JOIN climbs
    USING (climb_id);



SELECT * 
FROM climber_first_ascents
    JOIN climbs
    USING (climb_id);

DELETE cfa
FROM climber_first_ascents AS cfa
    JOIN climbs AS c
    USING (climb_id)
WHERE c.climb_established_date >= '2010-01-01';

SELECT * 
FROM climber_first_ascents
    JOIN climbs
    USING (climb_id);



--finally del from climbs
SELECT * 
FROM climbs;

DELETE c
FROM climbs AS c
WHERE c.climb_established_date >= '2010-01-01';

SELECT * 
FROM climbs;