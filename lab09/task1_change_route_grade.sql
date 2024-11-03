-- Write an SQL statement which will change all routes graded "5.10a" to grade "5.10b". The statement should use "5.10a" and "5.10b" directly, not grade_ids. Note: The climb_grades table is a validation table, and should not be modified.
USE red_river_climbs;

--takes a grade_str and output the grade_id for it
DROP FUNCTION IF EXISTS grade_str_to_grade_id;
CREATE FUNCTION grade_str_to_grade_id(input_grade_str CHAR(5))
RETURNS INT
RETURN (
    SELECT grade_id 
    FROM climb_grades 
    WHERE grade_str = input_grade_str
);

--just a small view to show all climbs with 5.10a or 5.10b
CREATE VIEW climbs_with_grades AS
SELECT * 
FROM    climbs
WHERE   grade_id IN (
    grade_str_to_grade_id('5.10a'),
    grade_str_to_grade_id('5.10b')
);

--start

SELECT * FROM climbs_with_grades;

--get grade_ids then do update
UPDATE  climbs
SET     grade_id = grade_str_to_grade_id('5.10b')
WHERE   grade_id = grade_str_to_grade_id('5.10a');

SELECT * FROM climbs_with_grades;
