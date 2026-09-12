CREATE SCHEMA seed;
GO
CREATE TABLE seed.customers (customer_id INT NOT NULL, customer_name VARCHAR(100) NOT NULL, segment VARCHAR(30) NOT NULL, country VARCHAR(50) NOT NULL);
CREATE TABLE seed.products (product_id INT NOT NULL, product_name VARCHAR(100) NOT NULL, category VARCHAR(50) NOT NULL, unit_price DECIMAL(10,2) NOT NULL);
CREATE TABLE seed.orders (order_id INT NOT NULL, order_date DATE NOT NULL, customer_id INT NOT NULL, product_id INT NOT NULL, quantity INT NOT NULL);
