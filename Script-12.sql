--CREACIÓN DE LA TABLA VENTAS de base de datos superstore

--#######################
--Tabla

CREATE TABLE ventas (
  row_id INTEGER,
  order_id VARCHAR(20),
  order_date DATE,
  ship_date DATE,
  ship_mode VARCHAR(30),
  customer_id VARCHAR(20),
  customer_name VARCHAR(100),
  segment VARCHAR(20),
  country VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(50),
  postal_code VARCHAR(10),
  region VARCHAR(20),
  product_id VARCHAR(20),
  category VARCHAR(30),
  sub_category VARCHAR(30),
  product_name VARCHAR(200),
  sales DECIMAL(10,4)
);

-- ###################################
-- IMPORTAR DATOS (ejecutar desde psql)
-- ###################################
 
-- Limpiar encoding primero con Python:
-- with open('train.csv', 'r', encoding='latin-1', errors='ignore') as f:
--     content = f.read()
-- with open('train_clean.csv', 'w', encoding='utf-8', errors='ignore') as f:
--     f.write(content)
 
\copy ventas FROM 'train_clean.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

-- ######################
-- Queries para análisis

-- ¿Cuántas ventas hace cada categoría?

SELECT category, ROUND(SUM(sales)::numeric, 2) AS total_ventas
FROM ventas
GROUP BY category
ORDER BY total_ventas DESC;

-- ¿Cuántas ventas hace cada región?

SELECT region, ROUND(SUM(sales)::numeric, 2) AS total_ventas
FROM ventas
GROUP BY region
ORDER BY total_ventas DESC;

-- ¿Cuál es la categoría más vendida por región?

SELECT region, category, ROUND(SUM(sales)::numeric, 2) AS total_ventas
FROM ventas
GROUP BY region, category
ORDER BY region, total_ventas DESC;

-- ¿Cuál es el tiempo promedio de envío según la modalidad de este?
SELECT region, category, total_ventas
FROM (
	SELECT region, category, 
        ROUND(SUM(sales)::numeric, 2) AS total_ventas,
        RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) as ranking
    FROM ventas
    GROUP BY region, category
) subconsulta
WHERE ranking = 1;

--¿Cuál es el tiempo de envío según la categoría o el modo de envío?

SELECT ship_mode,
ROUND(AVG(ship_date - order_date)::numeric, 2) AS promedio_dias
FROM ventas
GROUP BY ship_mode
ORDER BY promedio_dias DESC;


