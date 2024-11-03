-- Write a query which will produce a list of the top three route equippers in the database, and the number of routes they have helped to establish. The output should contain only two columns: the names of the top equippers, and their number of routes. The results must be shown in decreasing order by number of routes.

USE red_river_climbs;

SELECT *
FROM climber_climbs_established
    JOIN climbs
    USING (climb_id)
    JOIN climbers
    USING (climber_id);

SELECT CONCAT(climber_first_name, ' ', climber_last_name) AS climber_name, COUNT(climb_id) AS num_routes_established
FROM climber_climbs_established
    JOIN climbs
    USING (climb_id)
    JOIN climbers
    USING (climber_id)
GROUP BY (climber_id)
ORDER BY num_routes_established DESC
LIMIT 3;

/*

starting from climber_climbs_established, we're adding the info from climbs and climbers
we only care about climber, so GROUP by that
CONCAT(fname,lname) and to get the num_routes, we just count how many climb_ids there are
finally ordered by num_routes in DESC as per instructions + limit to 3

*/


