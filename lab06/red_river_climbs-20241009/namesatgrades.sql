USE red_river_climbs;

SELECT  grade_str, GROUP_CONCAT(climb_name) AS climb_names
FROM    climb_grades
        RIGHT OUTER JOIN climbs
        USING (grade_id)
GROUP BY grade_str;