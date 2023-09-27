-- SQL-команды для создания таблиц
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(25),
    last_name VARCHAR(50),
    title VARCHAR(100),
    birth_date DATE,
    notes text
);
CREATE TABLE customers (
    id INT PRIMARY KEY,
    company_name VARCHAR(50),
    contact_name VARCHAR(50)
);
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    ship_city VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);
