-- Write a sequence of SQL statements which will remove all routes from the database which were equipped in in 2010, or more recently

USE red_river_climbs;

--views

CREATE VIEW sport_climbs_full_info AS
SELECT * 
FROM sport_climbs
    JOIN climbs
    USING (climb_id);

CREATE VIEW trad_climbs_full_info AS
SELECT * 
FROM trad_climbs
    JOIN climbs
    USING (climb_id);

CREATE VIEW climber_climbs_established_full_info AS
SELECT * 
FROM climber_climbs_established
    JOIN climbs
    USING (climb_id);

CREATE VIEW climber_first_ascents_full_info AS
SELECT * 
FROM climber_first_ascents
    JOIN climbs
    USING (climb_id);




-- restrict rule in place so have del from subset tbl first

SELECT * FROM sport_climbs_full_info;

DELETE sc
FROM sport_climbs AS sc
    JOIN climbs AS c
    USING (climb_id)
WHERE c.climb_established_date >= '2010-01-01';

SELECT * FROM sport_climbs_full_info;



SELECT * FROM trad_climbs_full_info;

DELETE tc
FROM trad_climbs AS tc
    JOIN climbs AS c
    USING (climb_id)
WHERE c.climb_established_date >= '2010-01-01';

SELECT * FROM trad_climbs_full_info;



--need to del from climber_established and first ascents too :/
SELECT * FROM climber_climbs_established_full_info;

DELETE cce
FROM climber_climbs_established AS cce
    JOIN climbs AS c
    USING (climb_id)
WHERE c.climb_established_date >= '2010-01-01';

SELECT * FROM climber_climbs_established_full_info;



SELECT * FROM climber_first_ascents_full_info;

DELETE cfa
FROM climber_first_ascents AS cfa
    JOIN climbs AS c
    USING (climb_id)
WHERE c.climb_established_date >= '2010-01-01';

SELECT * FROM climber_first_ascents_full_info;



--finally del from climbs
SELECT * FROM climbs;

DELETE c
FROM climbs AS c
WHERE c.climb_established_date >= '2010-01-01';

SELECT * FROM climbs;

/*

so basically we're just going through all the child tables that contain climb_id,
joining with climbs (so we can check dates), del when >= 2010

i was thinking of using a func for the deletes 
since all the delete statements have a very similar
structure, but i dont think you can 
pass a tbl as args for functions

*/