-- Setup for Q3: Customers who bought products from both brand_1 and brand_2
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name  TEXT,
    last_name   TEXT
);

CREATE TABLE products (
    product_id  INT PRIMARY KEY,
    product_name TEXT,
    brand_name  TEXT
);

CREATE TABLE orders (
    order_id    INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id  INT REFERENCES products(product_id),
    order_date  DATE
);

-- Seed
INSERT INTO customers VALUES
(1,'Alice','Amin'),
(2,'Bob','Baron'),
(3,'Cathy','Chen'),
(4,'Dan','Doe');

INSERT INTO products VALUES
(100,'Pencil','brand_1'),
(101,'Notebook','brand_2'),
(102,'Eraser','brand_1'),
(103,'Marker','brand_3');

INSERT INTO orders VALUES
(1000,1,100,'2024-01-10'), -- Alice brand_1
(1001,1,101,'2024-01-11'), -- Alice brand_2 -> qualifies
(1002,2,100,'2024-01-12'), -- Bob brand_1 only
(1003,3,101,'2024-01-13'), -- Cathy brand_2 only
(1004,4,103,'2024-01-14'), -- Dan brand_3 only
(1005,2,102,'2024-01-15'); -- Bob brand_1 again
