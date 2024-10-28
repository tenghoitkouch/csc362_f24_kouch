SELECT  instrument_id, instrument_type, student_name
  FROM  instruments
        LEFT OUTER JOIN students
        USING (stud)
        