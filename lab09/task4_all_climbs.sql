USE red_river_climbs;


SELECT 
    c.climb_name, 
    g.grade_str, 
    c.climb_len_ft, 
    cr.crag_name, 
    GROUP_CONCAT(DISTINCT cfa_climbers.climber_first_name, ' ', cfa_climbers.climber_last_name) AS 'First ascent by', 
    GROUP_CONCAT(DISTINCT cce_climbers.climber_first_name, ' ', cce_climbers.climber_last_name) AS 'Equipped by' 
FROM climbs AS c
        JOIN climb_grades AS g
            USING (grade_id)
        JOIN crags AS cr
            USING (crag_id)
        LEFT OUTER JOIN climber_first_ascents AS cfa
            USING (climb_id)
        LEFT OUTER JOIN climbers AS cfa_climbers
            ON cfa.climber_id = cfa_climbers.climber_id
        LEFT OUTER JOIN climber_climbs_established AS cce
            USING (climb_id)
        LEFT OUTER JOIN climbers AS cce_climbers
            ON cce.climber_id = cce_climbers.climber_id
GROUP BY (c.climb_id);

/*

wow, i see why alias are useful now


start from climbs, join grades, crags
then join first_ascent with alias, then use that alias.climber_id to get the set of climbers
repeat for established

group by climb, b/c only want one record per climb each
now just a matter of CONCAT names together
+ DINTINCT b/c some people showed up more than once

*/
        