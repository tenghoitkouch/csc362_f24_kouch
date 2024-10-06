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
    customer_state          VARCHAR(2),
    customer_zip_code       VARCHAR(5),
    customer_phone_number   VARCHAR(10),
    customer_is_active      BOOLEAN DEFAULT TRUE
);

CREATE TABLE orders (
    customer_id                 INT,
    inventory_id                INT,
    order_sale_price            FLOAT,
    order_sale_date             DATE, 
    order_return_date           DATE CHECK (order_return_date >= order_sale_date),
    FOREIGN KEY                 (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY                 (inventory_id) REFERENCES inventory(inventory_id),
    PRIMARY KEY (customer_id, inventory_id)
);

CREATE TABLE trials (
    customer_id                 INT,
    inventory_id                INT,
    trial_start_date            DATE, 
    trial_expected_return_date  DATE,
    trial_actual_return_date    DATE CHECK (trial_actual_return_date >= trial_start_date AND trial_actual_return_date <= trial_expected_return_date),
    FOREIGN KEY (customer_id)   REFERENCES customers(customer_id),
    FOREIGN KEY (inventory_id)  REFERENCES inventory(inventory_id),
    PRIMARY KEY(customer_id, inventory_id)
);

-- check formatting
SHOW CREATE TABLE inventory;
SHOW CREATE TABLE customers;
SHOW CREATE TABLE orders;
SHOW CREATE TABLE trials;

INSERT INTO inventory (inventory_country, inventory_production_year, inventory_style, inventory_material, inventory_width, inventory_length, inventory_purchase_price, inventory_date_acquired, inventory_markup)
VALUES  ('Turkey',  '1925-01-01', 'Ushak',  'Wool', 5,  7,  625.00,     '2017-04-06', 1.00),
        ('Iran',    '1910-01-01', 'Tabriz', 'Silk', 10, 14, 28000.00,   '2017-04-06', 0.75),
        ('India',   '2017-01-01', 'Agra',   'Wool', 8,  10, 1200.00,    '2017-06-15', 1.00),
        ('India',   '2017-01-01', 'Agra',   'Wool', 4,  6,  450.00,     '2017-06-15', 1.20);

INSERT INTO customers (customer_first_name, customer_last_name, customer_street, customer_city, customer_state, customer_zip_code, customer_phone_number)
VALUES  ('Akira',       'Ingram',   '68 Country Drive',         'Roseville',        'MI', '48066',  '9262526716'),
        ('Meredith',    'Spencer',	'9044 Piper Lane',          'North Royalton',   'OH', '44133',	'8175305994'),
        ('Marco',       'Page',     '747 East Harrison Lane',   'Atlanta',          'GA', '30303',  '5887996535'),
        ('Sandra',      'Page',     '47 East Harrison Lane',    'Atlanta',          'GA', '30303',  '9976972666');

INSERT INTO customers (customer_first_name, customer_last_name, customer_street, customer_city, customer_state, customer_zip_code)
VALUES  ('Gloria',  'Gomez',    '78 Corona Rd.',        'Fullerton',    'CA', '92831'),
        ('Bria',    'Le',       '386 Silver Spear Ct',  'Coraopolis',   'PA', '15108');

INSERT INTO orders (customer_id, inventory_id, order_sale_date, order_sale_price)
VALUES  (5, 1, '2017-12-14', 990),
        (6, 3, '2017-12-24', 2400);

INSERT INTO orders (customer_id, inventory_id, order_sale_date, order_sale_price, order_return_date)
VALUES  (2, 2, '2017-12-24', 40000, '2017-12-26');

INSERT INTO trials (customer_id, inventory_id, trial_start_date, trial_expected_return_date)
VALUES  (1, 1, '2017-09-01', '2017-09-15');
        
SELECT * FROM inventory;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM trials;

