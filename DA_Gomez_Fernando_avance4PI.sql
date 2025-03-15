USE FastFood_DB;

-- Pregunta 1: Cómo puedo obtener una lista de todos los productos junto con sus categorías?
SELECT
  p.ProductoID,
  p.Nombre AS NombreProducto,
  c.Nombre AS NombreCategoria
FROM
  Productos AS p
INNER JOIN
  Categorias AS c
ON
  p.CategoriaID = c.CategoriaID; -- Usar solo JOIN es equivalente a usar INNER JOIN (Usar INNERJOIN es una mejor práctica).

-- Pregunta 2: Cómo puedo saber a qué sucursal está asignado cada empleado?
SELECT 
  e.EmpleadoID,
  e.Nombre AS NombreEmpleado,
  s.Nombre AS NombreSucursal
FROM
  Empleados AS e
INNER JOIN 
  Sucursales AS s
ON
  e.SucursalID = s.SucursalID; -- Al ejecutar la consulta vemos que todos los empleados cargados pertenecen a Sucursal Central (SucursalID = 1)

-- Pregunta 3: Existen productos que no tienen una categoría asignada?
SELECT
  p.ProductoID,
  p.Nombre AS NombreProducto
FROM
  Productos AS p
LEFT JOIN
  Categorias as c
ON
  p.CategoriaID = c.CategoriaID
WHERE 
  c.CategoriaID IS NULL; --  Al ejecutar la consulta vemos que no hay ninún producto que No este asignado a una categoria
  
/* Pregunta 4: Cómo puedo obtener un detalle completo de las órdenes, incluyendo el Nombre del cliente, 
Nombre del empleado que tomó la orden, y Nombre del mensajero que la entregó? */
SELECT
  o.OrdenID,
  c.Nombre AS NombreCliente,
  e.Nombre AS NombreEmpleado,
  m.Nombre AS NombreMensajero
FROM
  Ordenes AS o
INNER JOIN    
  Clientes AS c
ON
  o.ClienteID = c.ClienteID
INNER JOIN 
  Empleados AS e
ON
  o.EmpleadoID = e.EmpleadoID
INNER JOIN
  Mensajeros AS m
ON 
  o.MensajeroID = m.MensajeroID;

-- Pregunta 5: Cuántos artículos correspondientes a cada Categoría de Productos se han vendido en cada sucursal?
SELECT
  c.Nombre AS NombreCategoria,
  s.Nombre AS NombreSucursal,
  SUM (do.Cantidad) AS CantidadArticulosVendidos
FROM 
  DetalleOrdenes AS do
INNER JOIN
  Productos AS p
ON 
  do.ProductoID = p.ProductoID
INNER JOIN
  Categorias AS c
ON
  p.CategoriaID = c.CategoriaID
INNER JOIN
  Ordenes AS o
ON
  do.OrdenID = o.OrdenID
INNER JOIN 
  Sucursales as s
ON
  o.SucursalID = s.SucursalID
GROUP BY
 c.nombre, s.Nombre
ORDER BY CantidadArticulosVendidos DESC;
  





  