PRAGMA foreign_keys = ON;

-- ========== SETUP ==========
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  name        TEXT NOT NULL,
  email       TEXT NOT NULL UNIQUE,
  status      TEXT NOT NULL DEFAULT 'ACTIVE'
              CHECK (status IN ('ACTIVE','INACTIVE'))
);

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date  TEXT NOT NULL, -- YYYY-MM-DD
  amount      REAL NOT NULL CHECK (amount >= 0),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT
);

-- ========== SEED DATA ==========
INSERT INTO customers (customer_id, name, email, status) VALUES
(1, 'Arun', 'arun@example.com', 'ACTIVE'),
(2, 'Meena', 'meena@example.com', 'ACTIVE');

INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES
(101, 1, '2025-12-01', 250.00),
(102, 1, '2025-12-10',  99.50),
(103, 2, '2025-12-11', 500.00);

-- ========== TEST CASES (SQL CHECKS) ==========

-- TC_DB_001: Insert new customer (valid)
-- Expected: query returns found = 1
INSERT INTO customers (name, email, status)
VALUES ('Siva', 'siva@example.com', 'ACTIVE');

SELECT 'TC_DB_001' AS testcase, COUNT(*) AS found
FROM customers
WHERE email = 'siva@example.com';

-- TC_DB_002: Prevent duplicate email (negative)
-- Expected: UNIQUE constraint failed
INSERT INTO customers (name, email, status)
VALUES ('DuplicateArun', 'arun@example.com', 'ACTIVE');

-- TC_DB_003: Foreign key validation (negative)
-- Expected: FOREIGN KEY constraint failed
INSERT INTO orders (customer_id, order_date, amount)
VALUES (999, '2025-12-12', 10.0);

-- TC_DB_004: Update customer status (valid)
-- Expected: status becomes INACTIVE
UPDATE customers
SET status = 'INACTIVE'
WHERE email = 'meena@example.com';

SELECT 'TC_DB_004' AS testcase, status
FROM customers
WHERE email = 'meena@example.com';

-- Extra: Totals per customer
SELECT c.customer_id, c.name, SUM(o.amount) AS total_amount
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_amount DESC;
