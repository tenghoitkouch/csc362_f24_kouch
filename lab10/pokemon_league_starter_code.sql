DROP DATABASE IF EXISTS pokemon_league;
CREATE DATABASE pokemon_league;
USE pokemon_league;

CREATE TABLE trainers (
    trainer_id          INT AUTO_INCREMENT,
    trainer_name        VARCHAR(32),
    trainer_hometown    VARCHAR(32),
    PRIMARY KEY (trainer_id)
);


CREATE TABLE pokemon (
    pokemon_id          INT AUTO_INCREMENT,
    pokemon_species     VARCHAR(32),
    pokemon_level       INT,
    trainer_id          INT,
    pokemon_is_in_party BOOLEAN,
    PRIMARY KEY (pokemon_id),
    FOREIGN KEY (trainer_id) REFERENCES trainers (trainer_id),
    CONSTRAINT minimum_pokemon_level CHECK (pokemon_level >= 1),
    CONSTRAINT maximum_pokemon_level CHECK (pokemon_level <= 100)
);

DROP FUNCTION IF EXISTS get_party_size;
CREATE FUNCTION get_party_size(trainer_id_input INT)
RETURNS INT
RETURN (
    SELECT COUNT(pokemon_id)
        FROM    pokemon
        WHERE   trainer_id = trainer_id_input
                AND pokemon_is_in_party = TRUE
        GROUP BY (trainer_id)
);

DROP FUNCTION IF EXISTS get_trainer_id;
CREATE FUNCTION get_trainer_id(pokemon_id_input INT)
RETURNS INT
RETURN (
    SELECT trainer_id
        FROM    pokemon
        WHERE   pokemon_id = pokemon_id_input
);

DROP FUNCTION IF EXISTS get_party_status;
CREATE FUNCTION get_party_status(pokemon_id_input INT)
RETURNS INT
RETURN (
    SELECT pokemon_is_in_party
        FROM    pokemon
        WHERE   pokemon_id = pokemon_id_input
);


--range of 1 - 6 pokemon in party

DELIMITER $$
CREATE TRIGGER party_size_insert
BEFORE INSERT ON pokemon FOR EACH ROW  
BEGIN
    SET @current_party_size = get_party_size(NEW.trainer_id);

    IF @current_party_size >= 6 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Too many pokemon in party!';
    END IF;
END; $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER party_size_delete
BEFORE DELETE ON pokemon FOR EACH ROW  
BEGIN
    SET @current_party_size = get_party_size(OLD.trainer_id);

    IF @current_party_size <= 1 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Too little pokemon in party!';
    END IF;
END; $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER party_size_update
BEFORE UPDATE ON pokemon FOR EACH ROW  
BEGIN
    SET @old_party_size = get_party_size(OLD.trainer_id);
    SET @new_party_size = get_party_size(NEW.trainer_id);

    IF @new_party_size >= 6 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Too many pokemon in party!';
    END IF;

    IF @old_party_size <= 1 THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Too little pokemon in party!';
    END IF;
END; $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE trade_pokemon (pokemon_id_input INT, trainer1_id_input INT, trainer2_id_input INT)
BEGIN
    -- MariaDB uses error 1644 for unhandled user-defined exceptions.
    -- This makes sense when an error is not intended to be caught, in order to 
    -- prevent some action from occurring.
    DECLARE EXIT HANDLER FOR 45000
    BEGIN
    SELECT 'Procedure failed because of reasons!' as Error;
        ROLLBACK;
    END;

    -- <> is the not operator
    IF (get_trainer_id(pokemon_id_input) <> trainer1_id_input) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pokemon not owned by trainer 1!';
    END IF;

    IF (get_party_status(pokemon_id_input) = FALSE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pokemon not currently in party!';
    END IF;

    START TRANSACTION;
        
        UPDATE  pokemon
        SET     trainer_id = trainer2_id_input
        WHERE   pokemon_id = pokemon_id_input;

    COMMIT;

END; $$
DELIMITER ;


INSERT INTO trainers (trainer_name, trainer_hometown)
 VALUES ("Ash",     "Pallet Town"),
        ("Misty",   "Cerulean City"),
        ("Brock",   "Pewter City");


INSERT INTO pokemon (pokemon_species, pokemon_level, trainer_id, pokemon_is_in_party)
 VALUES ("Pikachu", "58", 1, TRUE),
        ("Staryu",  "44", 2, TRUE),
        ("Onyx",    "52", 3, TRUE),
        ("Magicarp","12", 1, FALSE);
        


--test for insert limit
INSERT INTO pokemon (pokemon_species, pokemon_level, trainer_id, pokemon_is_in_party)
 VALUES ("Pikachu", "58", 1, TRUE),
        ("Staryu",  "44", 1, TRUE),
        ("Onyx",    "52", 1, TRUE),
        ("Magicarp","12", 1, TRUE),
        ("Pikachu", "58", 1, TRUE),
        ("Staryu",  "44", 1, TRUE),
        ("Onyx",    "80", 1, FALSE);

--data for trade
INSERT INTO pokemon (pokemon_species, pokemon_level, trainer_id, pokemon_is_in_party)
 VALUES ("Onyx",    "80", 1, FALSE);

INSERT INTO pokemon (pokemon_species, pokemon_level, trainer_id, pokemon_is_in_party)
 VALUES ("Magicarp","12", 1, TRUE);

--test for del
DELETE FROM pokemon
WHERE   pokemon_id = 2;

--test for update
UPDATE pokemon
SET     trainer_id = 1
WHERE   pokemon_id = 3;

--test trade: 
SELECT * FROM pokemon;

CALL trade_pokemon (12, 2, 3); -- should fail, not owned by trainer 2
CALL trade_pokemon (12, 1, 3); -- should fail, not in party
CALL trade_pokemon (13, 1, 3); -- should work

SELECT * FROM pokemon;
