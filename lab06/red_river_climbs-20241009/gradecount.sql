USE red_river_climbs;

SELECT  grade_str, COUNT(climb_id)
FROM    climb_grades
        LEFT OUTER JOIN climbs
        USING (grade_id)
GROUP BY grade_str;
