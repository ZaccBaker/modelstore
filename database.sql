-- Testing purposes only
-- SET FOREIGN_KEY_CHECKS = 0;

-- Connecting to database
DROP USER IF EXISTS 'shop_employee'@'localhost';

CREATE USER 'shop_employee'@'localhost' IDENTIFIED WITH mysql_native_password BY 'merch23156';

GRANT ALL PRIVILEGES ON modelstore.* TO 'shop_employee'@'localhost';

-- Drop tables, if present
DROP TABLE IF EXISTS vendor;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS discount;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS payment;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS clearance;

-- Create vendor table
CREATE TABLE vendor(
    vendor_id           INT                 NOT NULL        AUTO_INCREMENT,
    vendor_name         VARCHAR(75)         NOT NULL,
    vendor_phone        VARCHAR(25),
    vendor_email        VARCHAR(50),

    PRIMARY KEY (vendor_id)
);

-- Create inventory table
CREATE TABLE inventory(
    inventory_id            INT                 NOT NULL        AUTO_INCREMENT,
    inventory_name          VARCHAR(75)         NOT NULL,
    inventory_quantity      INT,
    inventory_cost          FLOAT,
    inventory_retail        FLOAT,
    vendor_id               INT                 NOT NULL,

    PRIMARY KEY (inventory_id),

    CONSTRAINT fk_vendor
    FOREIGN KEY(vendor_id)
        REFERENCES vendor(vendor_id)
);

-- Create customer table
CREATE TABLE customer(
    customer_id                 INT             NOT NULL        AUTO_INCREMENT,
    customer_firstName          VARCHAR(75)     NOT NULL,
    customer_lastName           VARCHAR(75)     NOT NULL,
    customer_phone              VARCHAR(25),
    customer_email              VARCHAR(50),
    category_id                 INT             NOT NULL,

    PRIMARY KEY(customer_id),

    CONSTRAINT fk_category
    FOREIGN KEY(category_id)
        REFERENCES category(category_id)
);

-- Create category table
CREATE TABLE category(
    category_id         INT         NOT NULL            AUTO_INCREMENT,
    category_type       VARCHAR(75),
    discount_id         INT         NOT NULL,

    PRIMARY KEY(category_id),

    CONSTRAINT fk_discount
    FOREIGN KEY(discount_id)
        REFERENCES discount(discount_id)
);

-- Create discount table
CREATE TABLE discount(
    discount_id         INT         NOT NULL        AUTO_INCREMENT,
    discount_percent    INT,

    PRIMARY KEY(discount_id)
);

-- Create sales table
CREATE TABLE sales(
    sales_id            INT         NOT NULL        AUTO_INCREMENT,
    sales_totalPrice    FLOAT,
    sales_amount        INT,
    inventory_id        INT         NOT NULL,
    customer_id         INT         NOT NULL,
    payment_id          INT         NOT NULL,

    PRIMARY KEY (sales_id),

    CONSTRAINT fk_inventory
    FOREIGN KEY(inventory_id)
        REFERENCES inventory(inventory_id),

    CONSTRAINT fk_customer
    FOREIGN KEY(customer_id)
        REFERENCES customer(customer_id)
);

-- Create payment table
CREATE TABLE payment(
    payment_id      INT         NOT NULL        AUTO_INCREMENT,
    payment_type    VARCHAR(75),

    PRIMARY KEY(payment_id)
);

-- Create employee table
CREATE TABLE employee(
    employee_id     INT         NOT NULL        AUTO_INCREMENT,
    employee_firstName   VARCHAR(50)     NOT NULL,
    employee_lastName   VARCHAR(50)     NOT NULL,
    employee_phone  VARCHAR(25),
    employee_email  VARCHAR(50),
    clearance_id    INT         NOT NULL,

    PRIMARY KEY(employee_id),

    CONSTRAINT fk_clearance
    FOREIGN KEY(clearance_id)
        REFERENCES clearance(clearance_id)
);

-- Create clearance table
CREATE TABLE clearance(
    clearance_id        INT         NOT NULL        AUTO_INCREMENT,
    clearance_type      VARCHAR(50)     NOT NULL,

    PRIMARY KEY(clearance_id)
);

-- Insert vendors
INSERT INTO vendor(vendor_name, vendor_phone)
    VALUES('General Goods Hub', '860.154.1578');

INSERT INTO vendor(vendor_name, vendor_phone, vendor_email)
    VALUES('Universal Shopper', '423.189.8851', 'unishopper@shopping.org');

INSERT INTO vendor(vendor_name, vendor_email)
    VALUES('Merch Galore', 'merchgalore@shopping.org');

INSERT INTO vendor(vendor_name, vendor_phone)
    VALUES('Merch World', '891.255.4776');

-- Insert inventory
INSERT INTO inventory(inventory_name, inventory_quantity, inventory_cost, inventory_retail, vendor_id)
    VALUES('Shirt', '52', 7.50, 9.25, 3);

INSERT INTO inventory(inventory_name, inventory_quantity, inventory_cost, inventory_retail, vendor_id)
    VALUES('Hoodie', '143', 9.10, 12.50, 3);

INSERT INTO inventory(inventory_name, inventory_quantity, inventory_cost, inventory_retail, vendor_id)
    VALUES('Pants', '88', 8.25, 10.45, 4);

INSERT INTO inventory(inventory_name, inventory_quantity, inventory_cost, inventory_retail, vendor_id)
    VALUES('Shorts', '91', 6.10, 8.55, 4);

INSERT INTO inventory(inventory_name, inventory_quantity, inventory_cost, inventory_retail, vendor_id)
    VALUES('Duffle Bag', '45', 14.25, 18.99, 2);

INSERT INTO inventory(inventory_name, inventory_quantity, inventory_cost, inventory_retail, vendor_id)
    VALUES('Hat', '33', 9.75, 15.99, 1);

-- Insert customer
INSERT INTO customer(customer_firstName, customer_lastName, customer_phone, customer_email, category_id)
    VALUES('Rowan', 'Aguirre', '135.554.4138', 'rowanaguirre@school.org', 3);

INSERT INTO customer(customer_firstName, customer_lastName, customer_phone, customer_email, category_id)
    VALUES('Ann', 'Irwin', '318.551.6876', 'annirwin@school.org', 2);

INSERT INTO customer(customer_firstName, customer_lastName, customer_phone, customer_email, category_id)
    VALUES('Luther', 'Mendez', '486.135.8432', 'luthermendez@school.org', 3);

INSERT INTO customer(customer_firstName, customer_lastName, customer_phone, customer_email, category_id)
    VALUES('Jaden', 'Ali', '948.165.3218', 'jadenali@school.org', 1);

INSERT INTO customer(customer_firstName, customer_lastName, customer_phone, customer_email, category_id)
    VALUES('Archie', 'Chambers', '123.843.6135', 'archiechambers@school.org', 1);

INSERT INTO customer(customer_firstName, customer_lastName, customer_phone, customer_email, category_id)
    VALUES('Osman', 'Hardy', '012.154.7355', 'osmanhardy@school.org', 4);

INSERT INTO customer(customer_firstName, customer_lastName, customer_phone, customer_email, category_id)
    VALUES('Isabel', 'Atkins', '789.515.6548', 'isabelatkins@school.org', 1);

-- Insert category: types and connect with discount
INSERT INTO category(category_type, discount_id)
    VALUES('Student', 1);

INSERT INTO category(category_type, discount_id)
    VALUES('Parent', 1);

INSERT INTO category(category_type, discount_id)
    VALUES('Teacher', 2);

INSERT INTO category(category_type, discount_id)
    VALUES('Faculty Member', 3);

-- Insert discount
INSERT INTO discount(discount_percent)
    VALUES(0);

INSERT INTO discount(discount_percent)
    VALUES(15);

INSERT INTO discount(discount_percent)
    VALUES(20);

-- Insert sales - placeholder totalPrice
INSERT INTO sales(sales_totalPrice, inventory_id, customer_id, payment_id)
    VALUES(79.88, 1, 3, 2);

INSERT INTO sales(sales_totalPrice, inventory_id, customer_id, payment_id)
    VALUES(50.22, 5, 1, 2);

INSERT INTO sales(sales_totalPrice, inventory_id, customer_id, payment_id)
    VALUES(20.15, 2, 5, 3);

INSERT INTO sales(sales_totalPrice, inventory_id, customer_id, payment_id)
    VALUES(120.99, 4, 2, 2);

INSERT INTO sales(sales_totalPrice, inventory_id, customer_id, payment_id)
    VALUES(55.00, 1, 4, 2);

INSERT INTO sales(sales_totalPrice, inventory_id, customer_id, payment_id)
    VALUES(25.15, 2, 6, 1); 

INSERT INTO sales(sales_totalPrice, inventory_id, customer_id, payment_id)
    VALUES(36.75, 3, 3, 2);

-- Insert payment 
INSERT INTO payment(payment_type)
    VALUES('Cash');

INSERT INTO payment(payment_type)
    VALUES('Card');

INSERT INTO payment(payment_type)
    VALUES('Touchless');


-- Insert employee
INSERT INTO employee(employee_firstName, employee_lastName, employee_phone, employee_email, clearance_id)
    VALUES('Lucy', 'Bryan', '531.115.8843', 'lucybryan@school.org', 1);

INSERT INTO employee(employee_firstName, employee_lastName, employee_phone, employee_email, clearance_id)
    VALUES('Gloria', 'Orozco', '473.156.3218', 'gloriaorozco@school.org', 2);

INSERT INTO employee(employee_firstName, employee_lastName, employee_phone, employee_email, clearance_id)
    VALUES('Natalie', 'Larson', '469.863.6647', 'natalielarson@school.org', 3);

INSERT INTO employee(employee_firstName, employee_lastName, employee_phone, employee_email, clearance_id)
    VALUES('Elizabeth', 'Callahan', '732.947.3344', 'elizabethcallahan@school.org', 3);

INSERT INTO employee(employee_firstName, employee_lastName, employee_phone, employee_email, clearance_id)
    VALUES('Edna', 'Mann', '399.654.4468', 'ednamann@school.org', 3);

-- Insert clearance
INSERT INTO clearance(clearance_type)
    VALUES('Manager');

INSERT INTO clearance(clearance_type)
    VALUES('Assistant Manager');

INSERT INTO clearance(clearance_type)
    VALUES('General');