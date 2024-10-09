USE red_river_climbs;

SELECT  climb_name, grade_str
  FROM  climbs
        INNER JOIN climb_grades
        USING (grade_id)
        INNER JOIN crags
        USING (crag_id);
WHERE   crag_name = "Slab City";
