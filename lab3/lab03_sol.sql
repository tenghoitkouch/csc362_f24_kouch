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
    
)