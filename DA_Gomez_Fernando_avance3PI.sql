USE FastFood_DB;

-- Pregunta 1: Total de ventas globales
SELECT 
  SUM (TotalCompra) AS Total_ventas
  FROM Ordenes;

  -- Pregunta 2: promedio de precios de productos por categoría
  SELECT
    CategoriaID,
    CAST (AVG(Precio) AS DECIMAL (10,2)) AS Promedio_precio -- CAST permite convertir una columna de un tipo de dato a otro
	FROM Productos
	GROUP BY CategoriaID
	ORDER BY Promedio_precio DESC; -- ORDER BY funciona con alias

-- Pregunta 3: orden mínima y máxima por sucursal
SELECT
  SucursalID AS Sucursal,
  MIN(TotalCompra) AS Orden_minima, 
  MAX(TotalCompra) AS Orden_maxima
  FROM Ordenes
  GROUP BY SucursalID;

 -- Pregunta 4: mayor número de kilometros recorridos para una entrega
 SELECT
   TOP 1
   OrdenID,
     KilometrosRecorrer AS Numero_maximo_km
   FROM Ordenes
   ORDER BY Numero_maximo_km DESC;

 /* Pregunta 5: cantidad promedio de productos por orden  
 (Cantidad de productos por orden / cantidad de ordenes) */
 SELECT
   SUM (Cantidad) / COUNT (DISTINCT OrdenID) AS 'Promedio de productos por orden'
   FROM DetalleOrdenes;

 -- Pregunta 6: total de ventas por tipo de pago
 SELECT
   TipoPagoID AS Tipo_pago,
   SUM (TotalCompra) AS Total_venta
   FROM Ordenes
   GROUP BY TipoPagoID
   ORDER BY Total_venta DESC;

 -- Pregunta 7: sucursal con la venta promedio más alta
 SELECT 
   TOP 1
   SucursalID,
   AVG (TotalCompra) AS Venta_promedio
   FROM Ordenes
   GROUP BY SucursalID
   ORDER BY Venta_promedio;
   

 -- Pregunta 8: sucursal con la mayor cantidad de ventas por encima del umbral 1000
 SELECT
   SucursalID,
   SUM (TotalCompra) AS Venta_promedio
   FROM Ordenes
   GROUP BY SucursalID
   HAVING SUM (TotalCompra) > 1000
   ORDER BY Venta_promedio DESC;

-- Pregunta 9: como se compararan las ventas promedio antes y despues del 1° de julio de 2023?
SELECT
  'Despues_de_1_julio_2023' AS Periodo,
  AVG (TotalCompra) AS Venta_promedio
  FROM Ordenes
  WHERE FechaOrdenTomada > = '2023-07-01'

  UNION

SELECT
  'Antes_de_1_julio_2023' AS Periodo,
  AVG (TotalCompra) AS Venta_promedio
  FROM Ordenes
  WHERE FechaOrdenTomada <  '2023-07-01';

-- Pregunta 10: durante que momento del día (mañana, tarde o noche) se registra la mayor cantidad de ventas? 
-- cual es el ingreso promedio de estas ventas y cual ha sido el imoprte maximo alcanzado por una orden en dicha jornada?

SELECT
  HorarioVenta,
  COUNT (OrdenID) AS Venta_total,
  AVG (TotalCompra) AS Ingreso_promedio_ventas,
  MAX (TotalCompra) AS Venta_maxima
  FROM Ordenes
  GROUP BY HorarioVenta
  ORDER BY Venta_total DESC;



   


  