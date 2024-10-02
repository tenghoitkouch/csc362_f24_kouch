/*create*/
CREATE OR REPLACE DATABASE flying_carpets_gallery;

USE flying_carpets_gallery;

CREATE TABLE inventory (
    PRIMARY KEY(inventory_id),
    inventory_id                INT AUTO_INCREMENT,
    inventory_country           VARCHAR(128),
    inventory_production_year   DATE,
    inventory_style             VARCHAR(64),
    inventory_material          VARCHAR(64),
    inventory_width             INT,
    inventory_length            INT,
    inventory_purchase_price    FLOAT,
    inventory_date_acquired     DATE,
    inventory_markup            FLOAT
);

CREATE TABLE customers (
    PRIMARY KEY(customer_id),
    customer_id             INT AUTO_INCREMENT,
    customer_first_name     VARCHAR(64),
    customer_last_name      VARCHAR(64),
    customer_street         VARCHAR(128),
    customer_city           VARCHAR(64),
    customer_state          CHAR(2),
    customer_zip_code       CHAR(5),
    customer_phone_number   CHAR(10),
    customer_is_active      BOOLEAN
)

CREATE TABLE orders (
    customer_id                 INT,
    inventory_id                INT,
    order_sale_price            FLOAT,
    order_sale_date             DATETIME,
    order_return_date           DATETIME,
    FOREIGN KEY (customer_id)   REFERENCES consumers(consumer_id),
    FOREIGN KEY (inventory_id)  REFERENCES inventory(inventory_id),
    PRIMARY KEY(customer_id, inventory_id)
)

CREATE TABLE trials (
    customer_id                 INT,
    inventory_id                INT,
    trail_start_date            DATETIME,
    trail_expected_return_date  DATETIME,
    trail_actual_return_date    DATETIME,
    FOREIGN KEY (customer_id)   REFERENCES consumers(consumer_id),
    FOREIGN KEY (inventory_id)  REFERENCES inventory(inventory_id),
    PRIMARY KEY(customer_id, inventory_id)
);

-- check formatting
SHOW CREATE TABLE inventory;
SHOW CREATE TABLE consumers;
SHOW CREATE TABLE orders;
SHOW CREATE TABLE trials;

INSERT INTO inventory (inventory_country, inventory_production_year, inventory_style, inventory_material, inventory_width, inventory_length, inventory_purchase_price, inventory_date_acquired, inventory_markup)
VALUES  ('Turkey', '1925-01-01', 'Ushak', 'Wool', 5, 7, 625.00, '2017-04-06', 1.00),
        ('Iran', '1910-01-01', 'Tabriz', 'Silk', 10, 14, 28000.00, '2017-04-06', 0.75),
        ('India')


