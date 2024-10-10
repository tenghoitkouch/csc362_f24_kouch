USE red_river_climbs;

SELECT  grade_str
  FROM  climbs
        INNER JOIN climb_grades
        USING (grade_id)
        INNER JOIN crags
        USING (crag_id)
        INNER JOIN regions
        USING (region_id)
        INNER JOIN owners
        USING (owner_id)
WHERE   owner_name = "John and Elizabeth Muir"
GROUP BY (grade_str);
