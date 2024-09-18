DROP DATABASE IF EXISTS movie_ratings;

CREATE DATABASE movie_ratings;

USE movie_ratings;

CREATE TABLE movies (
    movies_movie_id INT AUTO_INCREMENT,
    movies_movie_title VARCHAR(256),
    movies_release_date DATE,
    movies_genre VARCHAR(512), 
    PRIMARY KEY (movies_movie_id)
)

CREATE TABLE consumers (
    consumers_consumer_id INT AUTO_INCREMENT,
    consumers_first_name VARCHAR(64),
    consumers_last_name VARCHAR(64),
    consumers_address VARCHAR(128),
    consumers_city VARCHAR(64),
    consumers_state VARCHAR(2),
    consumers_zip_code VARCHAR(5),
    PRIMARY KEY (consumers_consumer_id)
)

CREATE TABLE ratings (
    ratings_movie_id INT,
    ratings_consumer_id INT,
    ratings_when_dated DATETIME,
    ratings_number_stars INT,
    FOREIGN KEY (ratings_movie_id) REFERENCES movies(movies_movie_id),
    FOREIGN KEY (ratings_consumer_id) REFERENCES consumers(consumers_consumer_id),
    PRIMARY KEY (ratings_movie_id, ratings_consumer_id)

)