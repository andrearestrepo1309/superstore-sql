# Superstore Sales — Análisis SQL

Análisis exploratorio de ventas de una tienda retail estadounidense usando SQL en PostgreSQL.
El dataset contiene 9,800 órdenes con información de productos, clientes, regiones y envíos

## Preguntas que se buscan responder

- ¿Cuántas ventas hace cada categoría?
- ¿Cuántas ventas hace cada región?
- ¿Cuál es la categoría más vendida por región?
- ¿Cuál es el tiempo promedio de envío según la modalidad de este?
- ¿Cuál es el tiempo de envío según la categoría o el modo de envío?

---
## Hallazgos

- **Tecnología lidera las ventas** con $827K, seguida de Muebles ($728K) y Suministros de oficina ($705K). La diferencia no es abismal pero la tendencia es clara.

- **La región West genera casi el doble de ventas que el South** — $710K vs $389K. Aunque West y East están relativamente cerca, el South representa apenas el 55% de lo que vende el West, lo que muestra una desigualdad regional significativa.

- **Tecnología es la categoría favorita en todas las regiones** sin excepción. Sin embargo, el volumen varía bastante, $247K en el West vs $148K en el South, lo que significa que no es lo mismo liderar en una región que en otra.

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
