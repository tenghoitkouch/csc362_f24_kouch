-- Write an SQL statement which will change all routes graded "5.10a" to grade "5.10b". The statement should use "5.10a" and "5.10b" directly, not grade_ids. Note: The climb_grades table is a validation table, and should not be modified.
USE red_river_climbs;

-- SELECT * 
-- FROM    climbs
-- WHERE   grade_id IN (
--     SELECT grade_id
--     FROM climb_grades
--     WHERE grade_str IN ('5.10a', '5.10b')
-- );

UPDATE  climbs
SET     grade_id = (
    SELECT grade_id 
    FROM climb_grades 
    WHERE grade_str = '5.10b'
)
WHERE   grade_id = (
    SELECT grade_id 
    FROM climb_grades 
    WHERE grade_str = '5.10a'
);

-- SELECT * 
-- FROM    climbs
-- WHERE   grade_id IN (
--     SELECT grade_id
--     FROM climb_grades
--     WHERE grade_str IN ('5.10a', '5.10b')
-- );