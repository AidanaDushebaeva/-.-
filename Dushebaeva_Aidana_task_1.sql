-- Таблица должностей и отраслей
CREATE TABLE job_titles (
    job_title_id SERIAL PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL,
    job_industry_category VARCHAR(50) NOT NULL
);

-- Таблица локаций с привязкой к штатам и странам
CREATE TABLE locations (
    postcode INT PRIMARY KEY,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

-- Справочник товаров
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    brand VARCHAR(50) NOT NULL,
    product_line VARCHAR(50) NOT NULL,
    product_class VARCHAR(50) NOT NULL,
    product_size VARCHAR(50) NOT NULL
);

-- Таблица клиентов с основной информацией
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    DOB DATE NOT NULL,
    job_title_id INT REFERENCES job_titles(job_title_id) NOT NULL,
    wealth_segment VARCHAR(50) NOT NULL,
    deceased_indicator CHAR(1) NOT NULL CHECK (deceased_indicator IN ('Y', 'N')),
    owns_car VARCHAR(3) NOT NULL CHECK (owns_car IN ('Yes', 'No')),
    address VARCHAR(100) NOT NULL,
    postcode INT REFERENCES locations(postcode) NOT NULL,
    property_valuation INT NOT NULL CHECK (property_valuation > 0)
);

-- Таблица транзакций/заказов
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) NOT NULL,
    product_id INT REFERENCES products(product_id) NOT NULL,
    transaction_date DATE NOT NULL,
    online_order BOOLEAN NOT NULL,
    order_status VARCHAR(50) NOT NULL,
    list_price DECIMAL(10,2) NOT NULL CHECK (list_price >= 0),
    standard_cost DECIMAL(10,2) NOT NULL CHECK (standard_cost >= 0)
);
