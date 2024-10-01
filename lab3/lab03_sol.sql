/*
lab3, tenghoit kouch
this script creates a database movie ratings which includes three tables
movies - storing info about a movie
consumers - storing information about users
rating - stores ratings about a movie from users
*/

/*check existence*/
DROP DATABASE IF EXISTS movie_ratings;

CREATE DATABASE movie_ratings;

USE movie_ratings;

/*creating table*/
CREATE TABLE movies (
    movies_movie_id     INT AUTO_INCREMENT,
    movies_movie_title  VARCHAR(256),
    movies_release_date DATE,
    movies_genre        VARCHAR(512), 
    PRIMARY KEY         (movies_movie_id)
);

CREATE TABLE consumers (
    consumers_consumer_id   INT AUTO_INCREMENT,
    consumers_first_name    VARCHAR(64),
    consumers_last_name     VARCHAR(64),
    consumers_address       VARCHAR(128),
    consumers_city          VARCHAR(64),
    consumers_state         VARCHAR(2),
    consumers_zip_code      VARCHAR(5),
    PRIMARY KEY             (consumers_consumer_id)
);

CREATE TABLE ratings (
    movies_movie_id         INT,
    consumers_consumer_id   INT,
    ratings_when_dated      DATETIME,
    ratings_number_stars    INT,
    FOREIGN KEY             (movies_movie_id) REFERENCES movies(movies_movie_id),
    FOREIGN KEY             (consumers_consumer_id) REFERENCES consumers(consumers_consumer_id),
    PRIMARY KEY             (movies_movie_id, consumers_consumer_id)
);

/*checking formatting*/
SHOW CREATE TABLE movies;
SHOW CREATE TABLE consumers;
SHOW CREATE TABLE ratings;

/*insertings sample data*/
INSERT INTO movies (movies_movie_title, movies_release_date, movies_genre)
VALUES  ('The Hunt for Red October',        '1990-03-02', 'Acton, Adventure, Thriller'),
        ('Lady Bird',                       '2017-12-01', 'Comedy, Drama'),
        ('Inception',                       '2010-08-16', 'Acton, Adventure, Science Fiction'),
        ('Monty Python and the Holy Grail', '1975-04-03', 'Comedy');

INSERT INTO consumers (consumers_first_name, consumers_last_name, consumers_address, consumers_city, consumers_state, consumers_zip_code)
VALUES  ('Toru',    'Okada',    '800 Glenridge Ave',    'Hobart',       'IN', '46343'),
        ('Kumiko',  'Okada',    '864 NW Bohemia St',    'Vincentown',   'NJ', '08088'),
        ('Noboru',  'Wataya',   '342 Joy Ridge St',     'Hermitage',    'TN', '37076'),
        ('May',     'Kasahara', '5 Kent Rd',            'East Haven',   'CT', '06512');

INSERT INTO ratings (movies_movie_id, consumers_consumer_id, ratings_when_dated, ratings_number_stars)
VALUES  (1, 1, '2010-09-02 10:54:19', 4),
        (1, 3, '2012-08-05 15:00:01', 3),
        (1, 4, '2016-10-02 23:58:12', 1),
        (2, 3, '2017-03-27 00:12:48', 2),
        (2, 4, '2018-08-02 00:54:42', 4);


/*viewing data*/
SELECT * FROM movies;
SELECT * FROM consumers;
SELECT * FROM ratings;


/* Generate a report */
SELECT consumers_first_name, consumers_last_name, movies_movie_title, ratings_number_stars
    FROM movies
        NATURAL JOIN ratings
        NATURAL JOIN consumers;



/* 
problem: genre field is movies is a multivalued field

solution: create a table for the genres, and then have a linking table connecting movies and genres
*/



DROP DATABASE IF EXISTS movie_ratings;

CREATE DATABASE movie_ratings;

USE movie_ratings;

/* creates genre */
CREATE TABLE genres (
    genres_id   INT AUTO_INCREMENT,
    genres_name VARCHAR(64),
    PRIMARY KEY (genres_id)
);

/*creating table*/
CREATE TABLE movies (
    movies_movie_id     INT AUTO_INCREMENT,
    movies_movie_title  VARCHAR(256),
    movies_release_date DATE,
    PRIMARY KEY         (movies_movie_id)
);

CREATE TABLE movies_genres (
    movies_movie_id     INT,
    genres_id           INT,
    FOREIGN KEY         (movies_movie_id) REFERENCES movies(movies_movie_id),
    FOREIGN KEY         (genres_id) REFERENCES genres(genres_id),
    PRIMARY KEY         (movies_movie_id, genres_id)
);

CREATE TABLE consumers (
    consumers_consumer_id   INT AUTO_INCREMENT,
    consumers_first_name    VARCHAR(64),
    consumers_last_name     VARCHAR(64),
    consumers_address       VARCHAR(128),
    consumers_city          VARCHAR(64),
    consumers_state         VARCHAR(2),
    consumers_zip_code      VARCHAR(5),
    PRIMARY KEY             (consumers_consumer_id)
);

CREATE TABLE ratings (
    movies_movie_id         INT,
    consumers_consumer_id   INT,
    ratings_when_dated      DATETIME,
    ratings_number_stars    INT,
    FOREIGN KEY             (movies_movie_id) REFERENCES movies(movies_movie_id),
    FOREIGN KEY             (consumers_consumer_id) REFERENCES consumers(consumers_consumer_id),
    PRIMARY KEY             (movies_movie_id, consumers_consumer_id)
);

/*checking formatting*/
SHOW CREATE TABLE movies;
SHOW CREATE TABLE genres;
SHOW CREATE TABLE movies_genres;
SHOW CREATE TABLE consumers;
SHOW CREATE TABLE ratings;

/*insertings sample data*/
INSERT INTO movies (movies_movie_title, movies_release_date)
VALUES  ('The Hunt for Red October',        '1990-03-02'),
        ('Lady Bird',                       '2017-12-01'),
        ('Inception',                       '2010-08-16'),
        ('Monty Python and the Holy Grail', '1975-04-03');

INSERT INTO genres (genres_name)
VALUES  ('Acton'),
        ('Adventure'),
        ('Thriller'),
        ('Comedy'),
        ('Drama'),
        ('Science Fiction');

INSERT INTO movies_genres (movies_movie_id, genres_id)
VALUES  (1, 1),
        (1, 2),
        (1, 3),
        (2, 4),
        (2, 5),
        (3, 1),
        (3, 2),
        (3, 6),
        (4, 4);

INSERT INTO consumers (consumers_first_name, consumers_last_name, consumers_address, consumers_city, consumers_state, consumers_zip_code)
VALUES  ('Toru',    'Okada',    '800 Glenridge Ave',    'Hobart',       'IN', '46343'),
        ('Kumiko',  'Okada',    '864 NW Bohemia St',    'Vincentown',   'NJ', '08088'),
        ('Noboru',  'Wataya',   '342 Joy Ridge St',     'Hermitage',    'TN', '37076'),
        ('May',     'Kasahara', '5 Kent Rd',            'East Haven',   'CT', '06512');

INSERT INTO ratings (movies_movie_id, consumers_consumer_id, ratings_when_dated, ratings_number_stars)
VALUES  (1, 1, '2010-09-02 10:54:19', 4),
        (1, 3, '2012-08-05 15:00:01', 3),
        (1, 4, '2016-10-02 23:58:12', 1),
        (2, 3, '2017-03-27 00:12:48', 2),
        (2, 4, '2018-08-02 00:54:42', 4);

/*viewing data*/
SELECT * FROM movies;
SELECT * FROM genres;
SELECT * FROM movies_genres;
SELECT * FROM consumers;
SELECT * FROM ratings;


/* Generate a report */
SELECT consumers_first_name, consumers_last_name, movies_movie_title, ratings_number_stars
    FROM movies
        NATURAL JOIN ratings
        NATURAL JOIN consumers;