/*check if already exist*/
DROP DATABASE IF EXISTS school;

CREATE DATABASE school;

USE school;


CREATE TABLE instructors (
    PRIMARY KEY (instructor_id),
    instructor_id INT AUTO_INCREMENT,
    instructor_first_name VARCHAR(50),
    instructor_last_name VARCHAR(50),
    /*apparently phone numbers should be stored as strings*/
    instructor_campus_phone VARCHAR(50)
);

/*inputs*/
INSERT INTO instructors (instructor_first_name, instructor_last_name, instructor_campus_phone)
VALUES  ('Kira', 'Bently', '221-363-9948'),
        ('Bill', 'Champlin', '230-527-4992'),
        ('Shannon', 'Black', '230-336-5992'),
        ('Estela', 'Rosales', '221-336-6992');

/*display all*/
SELECT * FROM instructors;