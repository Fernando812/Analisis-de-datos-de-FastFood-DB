USE FastFood_DB;

-- Pregunta 1: Cu�l es el tiempo promedio desde el despacho hasta la entrega de los pedidos gestionados por todo el equipo de mensajer�a?
SELECT
  AVG (DATEDIFF(minute, FechaDespacho, FechaEntrega)) AS 'PromedioTiempoEntregaMensajeros(minutos)'
FROM Ordenes;

-- Pregunta 2: Qu� canal de ventas genera m�s ingresos?
SELECT 
TOP 1
  A.Descripcion AS CanalVenta, SUM (B.TotalCompra) AS TotalIngresos
FROM OrigenOrden AS A
  INNER JOIN Ordenes AS B ON A.OrigenID = B.OrigenID
  GROUP BY A.Descripcion
  ORDER BY TotalIngresos DESC; 

-- Pregunta 3: Cu�l es el nivel de ingreso generado por Empleado?
SELECT
  A.EmpleadoID, A.Nombre AS NombreEmpleado, SUM (B.TotalCompra) AS IngresosGenerados
FROM Empleados AS A
  INNER JOIN Ordenes AS B ON A.EmpleadoID = B.EmpleadoID
  GROUP BY A.EmpleadoID, A.Nombre
  ORDER BY IngresosGenerados DESC;

/* Pregunta 4: �C�mo var�a la demanda de productos a lo largo del d�a? NOTA: Esta consulta no puede ser implementada 
   sin una definici�n clara del horario (ma�ana, tarde, noche) en la base de datos existente. 
   Asumiremos que HorarioVenta refleja esta informaci�n correctamente */
SELECT 
  A.HorarioVenta, SUM(B.Cantidad) AS TotalProductosVendidos
FROM Ordenes AS A
LEFT JOIN DetalleOrdenes AS B ON A.OrdenID = B.OrdenID
  GROUP BY A.HorarioVenta
  ORDER BY TotalProductosVendidos DESC;
  /* Al ejecutar la consulta, en la tabla respuesta se observa que todos los productos vendidos se vendieron en el horario 'ma�ana'
  y que no se realizaron ventas por la noche ni por la tarde, esto es porque los datos que nos dieron para ingresar 
  a la tabla 'DetalleOrdenes' tienen OrdenID = 1 en todas las filas y la Orden con OrdenID = 1 
  corresponde a una venta realizada por la ma�ana. */ 
  
-- Pregunta 5: Cu�l es la tendencia de los ingresos generados en cada periodo mensual?
SELECT
  DATENAME (Month, FechaOrdenTomada) AS 'Mes', -- DATENAME devuelve el nombre del mes o del dia de una fecha seg�n se lo indiquemos
  SUM (TotalCompra) AS 'IngresosGenerados'
FROM Ordenes
 GROUP BY DATENAME (Month, FechaOrdenTomada)
 ORDER BY 'IngresosGenerados' DESC;

/* Pregunta 6: Qu� porcentaje de clientes son recurrentes versus nuevos clientes cada mes? NOTA: La consulta se enfocar�a 
   en la frecuencia de �rdenes por cliente para inferir la fidelidad.
   % Clientes nuevos = (Clientes con 1 sola orden asignada/Total clientes) x 100 
   % Clientes recurrentes = (Clientes con mas de una orden asignada/Total clientes) x 100 */
SELECT 
    Mes,
    SUM(CASE WHEN Clientes = 1 THEN 1 ELSE 0 END) / COUNT (*) * 100 AS PorcentajeClientesNuevos,
    SUM(CASE WHEN Clientes > 1 THEN 1 ELSE 0 END) / COUNT (*) * 100 AS PorcentajeClientesRecurrentes
FROM 
	(SELECT
		COUNT (DISTINCT ClienteID) AS Clientes,
		DATENAME (Month, FechaOrdenTomada) AS Mes,
		MONTH (FechaOrdenTomada) AS NumeroMes
	FROM Ordenes
    GROUP BY DATENAME (Month, FechaOrdenTomada), MONTH (FechaOrdenTomada)) AS ClientesPorMes
GROUP BY Mes, NumeroMes
ORDER BY NumeroMes;
/* En la respuesta vemos que cada mes el 100% de los clientes son nuevos ya que cada orden cargada corresponde 
a un Cliente con diferente ClienteID */


