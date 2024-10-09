USE red_river_climbs;

SELECT  climb_name, grade_str, climb_len_ft, crag_name 
  FROM  climbs
        INNER JOIN climb_grades
        USING (grade_id)
        INNER JOIN crags
        USING (crag_id)
 WHERE  grade_str LIKE '5.9';