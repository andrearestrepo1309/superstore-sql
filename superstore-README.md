# 🛒 Superstore Sales — Análisis SQL

Análisis exploratorio de ventas de una tienda retail estadounidense usando SQL en PostgreSQL.
El dataset contiene 9,800 órdenes con información de productos, clientes, regiones y envíos.

---

## 🎯 Preguntas que responde este análisis

- ¿Qué categoría de producto genera más ventas?
- ¿Qué región del país vende más?
- ¿Cada región tiene preferencia por alguna categoría?
- ¿Cuánto tarda cada modalidad de envío?
- ¿El tiempo de envío depende del tipo de producto?

---

## 🗂️ Estructura de la base de datos

```sql
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
```

---

## 🔍 Queries destacadas

### 1. Ventas por categoría

```sql
SELECT category, ROUND(SUM(sales)::numeric, 2) AS total_ventas
FROM ventas
GROUP BY category
ORDER BY total_ventas DESC;
```

### 2. Ventas por región

```sql
SELECT region, ROUND(SUM(sales)::numeric, 2) AS total_ventas
FROM ventas
GROUP BY region
ORDER BY total_ventas DESC;
```

### 3. Categoría más vendida por región (Window Function)

```sql
SELECT region, category, total_ventas
FROM (
    SELECT 
        region, 
        category, 
        ROUND(SUM(sales)::numeric, 2) AS total_ventas,
        RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS ranking
    FROM ventas
    GROUP BY region, category
) subconsulta
WHERE ranking = 1;
```

### 4. Tiempo promedio de envío por modalidad

```sql
SELECT 
    ship_mode,
    ROUND(AVG(ship_date - order_date)::numeric, 2) AS promedio_dias
FROM ventas
GROUP BY ship_mode
ORDER BY promedio_dias;
```

### 5. Tiempo de envío por categoría y modalidad

```sql
SELECT 
    category,
    ship_mode,
    ROUND(AVG(ship_date - order_date)::numeric, 2) AS promedio_dias
FROM ventas
GROUP BY category, ship_mode
ORDER BY promedio_dias DESC;
```

---

## 📊 Hallazgos

- **Tecnología lidera las ventas** con $827K, seguida de Muebles ($728K) y Suministros de oficina ($705K). La diferencia no es abismal pero la tendencia es clara.

- **La región West genera casi el doble de ventas que el South** — $710K vs $389K. Aunque West y East están relativamente cerca, el South representa apenas el 55% de lo que vende el West, lo que muestra una desigualdad regional significativa.

- **Tecnología es la categoría favorita en todas las regiones** sin excepción. Sin embargo, el volumen varía bastante — $247K en el West vs $148K en el South, lo que significa que no es lo mismo liderar en una región que en otra.

- **El tiempo de envío depende exclusivamente del modo de envío**, no del tipo de producto:
  - Same Day: 0 días
  - First Class: ~2 días
  - Second Class: ~3 días
  - Standard Class: ~5 días

- **No existe una preferencia de envío por categoría de producto** — los tiempos son prácticamente iguales entre categorías para el mismo modo de envío. El cliente escoge el modo de envío de forma independiente al producto que compra.

---

## 🛠️ Tecnologías usadas

- **PostgreSQL 18**
- **DBeaver** — cliente SQL
- **SQL** — DDL, DML, GROUP BY, Window Functions, Subqueries

---

## 👩‍💻 Autora

**Andrea Sierra Restrepo**  
Ingeniera Electrónica — Universidad Tecnológica de Pereira  
[LinkedIn](https://www.linkedin.com/in/andrea-sierra-restrepo-753870278/) · [GitHub](https://github.com/andrearestrepo1309)
