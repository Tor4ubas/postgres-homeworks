-- SQL-команды для создания таблиц
CREATE TABLE employees (
    employee_id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(100) NOT NULL,
    birth_date DATE,
    notes text
);
CREATE TABLE customers (
    customer_id VARCHAR(5) PRIMARY KEY,
    company_name VARCHAR(50),
    contact_name VARCHAR(50)
);
CREATE TABLE orders (
    order_id INT NOT NULL PRIMARY KEY,
    customer_id VARCHAR(5),
    employee_id INT NOT NULL,
    order_date DATE,
    ship_city VARCHAR(50)
);
