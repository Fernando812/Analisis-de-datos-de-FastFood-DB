-- PASO 1: CREAR LA BASE DE DATOS
CREATE DATABASE FastFood_DB
ON
(
	NAME = 'FasFoodDB_Data',
	FILENAME = 'C:\SQLdata\FastFoodDB_Data.mdf',
	SIZE = 50MB,
	MAXSIZE = 1GB,
	FILEGROWTH = 5 MB
)
LOG ON
(
	NAME = 'Carrera_BD_Log',
	FILENAME = 'C:\SQLdata\FastFoodDB_Data.ldf',
	SIZE = 25MB,
	MAXSIZE = 256MB,
	FILEGROWTH = 5MB
)
;

-- ACTIVAMOS LA BASE DE DATOS
USE FastFood_DB;

SELECT
name,database_id,create_date
FROM sys.databases
WHERE name = 'FastFood_DB'
;

-- CREAR TABLAS
-- CATEGORIAS
CREATE TABLE Categorias
(
	CategoriaID INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(100) NOT NULL
)
;
-- PRODUCTOS
CREATE TABLE Productos
(
	ProductoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	CategoriaID INT,
	Precio DECIMAL(10,2) NOT NULL,
	FOREIGN KEY(CategoriaID) REFERENCES Categorias(CategoriaID)
)
;

-- SUCURSALES
CREATE TABLE Sucursales
(
	SucursalID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	Direccion VARCHAR(100) NOT NULL
)
;

-- EMPLEADOS
CREATE TABLE Empleados
(
	EmpleadoID INT PRIMARY KEY IDENTITY (1,1),
	Nombre VARCHAR(100) NOT NULL,
	Posicion VARCHAR(100),
	Departamento VARCHAR(100),
	SucursalID INT,
	Rol VARCHAR(50) NOT NULL,
	FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID)
)
;

-- CLIENTES
CREATE TABLE Clientes
(
	ClienteID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	Direccion VARCHAR(100)
)
;

-- ORIGEN ORDEN
CREATE TABLE OrigenOrden
(
	OrigenID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255) NOT NULL
)
;


-- TIPOS DE PAGO
CREATE TABLE TiposPago
(
	TipoPagoID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(100) NOT NULL
)
;

-- MENSAJERO
CREATE TABLE Mensajeros
(
	MensajeroID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(100) NOT NULL,
	EsExterno BIT NOT NULL
)
;

-- ORDENES
CREATE TABLE Ordenes
(
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT,
	EmpleadoID INT,
	SucursalID INT,
	MensajeroID INT,
	TipoPagoID INT,
	OrigenID INT,
	HorarioVenta VARCHAR(100) NOT NULL,
	TotalCompra DECIMAL(10,2) NOT NULL,
	KilometrosRecorrer DECIMAL(10,2),
	FechaDespacho DATETIME,
	FechaEntrega DATETIME,
	FechaOrdenTomada DATETIME,
	FechaOrdenLista DATETIME,
	FOREIGN KEY(ClienteID) REFERENCES Clientes(ClienteID),
	FOREIGN KEY(EmpleadoID) REFERENCES Empleados(EmpleadoID),
	FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID),
	FOREIGN KEY(MensajeroID) REFERENCES Mensajeros(MensajeroID),
	FOREIGN KEY(TipoPagoID) REFERENCES TiposPago(TipoPagoID),
	FOREIGN KEY(OrigenID) REFERENCES OrigenOrden(OrigenID)
)
;

CREATE TABLE DetalleOrdenes
(
	OrdenID INT,
	ProductoID INT,
	Cantidad INT,
	Precio DECIMAL(10,2),
	PRIMARY KEY (OrdenID,ProductoID),
	FOREIGN KEY(ProductoID) REFERENCES Productos(ProductoID),
	FOREIGN KEY(OrdenID) REFERENCES Ordenes(OrdenID)
)
;

ALTER TABLE DetalleOrdenes
ADD Comentarios VARCHAR(100)

;