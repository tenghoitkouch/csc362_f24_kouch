USE red_river_climbs;

SELECT  climb_name, grade_str, trad_climb_descent
  FROM  trad_climbs
        INNER JOIN climbs
        USING (climb_id)
        INNER JOIN climb_grades
        USING (grade_id);