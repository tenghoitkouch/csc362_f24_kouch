USE red_river_climbs;

SELECT  climber_first_name, climber_last_name, MAX(grade_str) AS grade_str
FROM    climber_climbs_established
        INNER JOIN climbers
        USING (climber_id)
        INNER JOIN climbs
        USING (climb_id)
        INNER JOIN climb_grades
        USING (grade_id)
GROUP BY climber_id;
