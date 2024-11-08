CREATE DATABASE Ecommerce
GO 

USE Ecommerce
GO

CREATE TABLE Promocion (
    IdPromocion INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(100),
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
	CONSTRAINT CK_FechaInicio_FechaFin CHECK (FechaFin >= FechaInicio)
);

CREATE TABLE Editorial (
    IdEditorial INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Categoria (
    IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(100)
);

CREATE TABLE Libro (
    IdLibro INT IDENTITY(1,1) PRIMARY KEY,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    IdEditorial INT NOT NULL,
    AnioEdicion INT NOT NULL,
    IdCategoria INT NOT NULL,
    Stock INT CONSTRAINT DF_Stock DEFAULT (0),
    Imagen VARCHAR(MAX),
    CONSTRAINT FK_Libro_Editorial 
		FOREIGN KEY (IdEditorial) REFERENCES Editorial(IdEditorial),
    CONSTRAINT FK_Libro_Categoria 
		FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria),
	CONSTRAINT CK_AnioEdicion 
		CHECK (AnioEdicion >= 0),
	CONSTRAINT CK_Cantidad_Stock 
		CHECK (Stock >= 0)
);


CREATE TABLE DetallePromocion (
    IdDetallePromocion INT IDENTITY(1,1) PRIMARY KEY,
    IdPromocion INT NOT NULL,
    IdLibro INT NOT NULL,
    CONSTRAINT FK_DetallePromocion_Promocion 
		FOREIGN KEY (IdPromocion) REFERENCES Promocion(IdPromocion),
    CONSTRAINT FK_DetallePromocion_Libro 
		FOREIGN KEY (IdLibro) REFERENCES Libro(IdLibro)
);


CREATE TABLE Precios (
    IdPrecio INT IDENTITY(1,1) PRIMARY KEY,
    IdLibro INT NOT NULL,
    Costo MONEY NOT NULL,
    Fecha DATE NOT NULL,
    CONSTRAINT FK_Precios_Libro 
		FOREIGN KEY (IdLibro) REFERENCES Libro(IdLibro),
	CONSTRAINT CK_Precio CHECK (Precio >= 0) 
);

CREATE TABLE MetodoPago (
    IdMetodoPago INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Rol (
    IdRol INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Departamento (
    IdDepartamento INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Provincia (
    IdProvincia INT IDENTITY(1,1) PRIMARY KEY,
	IdDepartamento INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
	CONSTRAINT FK_Provincia_Departamento
		FOREIGN KEY (IdDepartamento) REFERENCES Departamento(IdDepartamento),
);

CREATE TABLE Distrito (
    IdDistrito INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
	IdProvincia INT NOT NULL,
    CONSTRAINT FK_Distrito_Provincia
		FOREIGN KEY (IdProvincia) REFERENCES Provincia(IdProvincia)
);


CREATE TABLE Direccion (
    IdDireccion INT IDENTITY(1,1) PRIMARY KEY,
    Departamento VARCHAR(100) NOT NULL,
	Provincia VARCHAR(100) NOT NULL,
	Distrito VARCHAR(100) NOT NULL,
	Calle VARCHAR(100) NOT NULL,
);

CREATE TABLE Usuario (
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    ApellidoPaterno VARCHAR(50) NOT NULL,
    ApellidoMaterno VARCHAR(50),
    NumeroCelular VARCHAR(20) UNIQUE,
    Correo VARCHAR(100) UNIQUE,
    Contrasenia VARCHAR(60) NOT NULL,
    IdRol INT,
    IdDireccion INT NOT NULL,
    CONSTRAINT FK_Usuario_Rol 
		FOREIGN KEY (IdRol) REFERENCES Rol(IdRol),
    CONSTRAINT FK_Usuario_Direccion 
		FOREIGN KEY (IdDireccion) REFERENCES Direccion(IdDireccion)
);

CREATE TABLE Pedido (
    IdPedido INT IDENTITY(1,1) PRIMARY KEY,
	IdUsuario INT NOT NULL,
    NumeroSerie VARCHAR(50) UNIQUE NOT NULL,
    FechaCompra DATE NOT NULL,
    IdMetodoPago INT NOT NULL,
    CONSTRAINT FK_Pedido_MetodoPago 
		FOREIGN KEY (IdMetodoPago) REFERENCES MetodoPago(IdMetodoPago),
	CONSTRAINT FK_Pedido_Usuario 
		FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
);


CREATE TABLE DetallePedido (
    IdDetallePedido INT IDENTITY(1,1) PRIMARY KEY,
    IdLibro INT NOT NULL,
    Cantidad INT CONSTRAINT DF_Cantidad DEFAULT (0),
    IdPedido INT NOT NULL,
    CONSTRAINT FK_DetallePedido_Libro 
		FOREIGN KEY (IdLibro) REFERENCES Libro(IdLibro),
    CONSTRAINT FK_DetallePedido_Pedido 
		FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido),
	CONSTRAINT CK_Cantidad CHECK (Cantidad > 0)
);

CREATE TABLE Notificacion (
    IdNotificacion INT IDENTITY(1,1) PRIMARY KEY,
    IdUsuario INT NOT NULL,
    Mensaje VARCHAR(100) NOT NULL,
    FechaEnvio DATETIME NOT NULL,
    CONSTRAINT FK_Notificacion_Usuario 
		FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE Igv(
	IdIgv INT IDENTITY(1,1) PRIMARY KEY,
	Valor NUMERIC(3,2) NOT NULL,
	Fecha DATE NOT NULL,
	CONSTRAINT CK_Valor_IGV CHECK (Valor>=0 AND Valor<=1) 
)

CREATE TABLE Resenia(
	IdResenia INT IDENTITY(1,1) PRIMARY KEY,
	IdPedido INT NOT NULL,
	IdUsuario INT NOT NULL,
	Comentario VARCHAR(500) NOT NULL, 
	Calificacion INT NOT NULL,
	Fecha DATE NOT NULL,
	CONSTRAINT FK_Resenia_Pedido 
		FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido),
	CONSTRAINT FK_Resenia_Usuario 
		FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
	CONSTRAINT CK_Calificacion CHECK (Calificacion BETWEEN 0 AND 5)
);

CREATE TABLE EstadoPedido(
	IdEstadoPedido INT IDENTITY(1,1) PRIMARY KEY,
	IdPedido INT NOT NULL,
	Estado VARCHAR(10) NOT NULL, 
	Fecha DATETIME NOT NULL,
	CONSTRAINT FK_EstadoPedido_Pedido 
		FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido),
	CONSTRAINT CK_Estados_Validos 
		CHECK (Estado in ('Pendiente','Enviado','Entregado'))
);


-- Procedimientos Almacenados
-- SP Igv
CREATE PROCEDURE sp_InsertarIgv
    @Valor NUMERIC(3,2),
    @Fecha DATE
AS
BEGIN
    INSERT INTO Igv (Valor, Fecha)
    VALUES (@Valor, @Fecha)
END;

CREATE PROCEDURE sp_ActualizarIgv
    @IdIgv INT,
    @Valor NUMERIC(3,2),
    @Fecha DATE
AS
BEGIN
    UPDATE Igv
    SET Valor = @Valor, Fecha = @Fecha
    WHERE IdIgv = @IdIgv
END;

CREATE PROCEDURE sp_EliminarIgv
    @IdIgv INT
AS
BEGIN
    DELETE FROM Igv
    WHERE IdIgv = @IdIgv
END;

CREATE PROCEDURE sp_SeleccionarTodosIgv
AS
BEGIN
    SELECT * FROM Igv
END;

CREATE PROCEDURE sp_SeleccionarIgvPorId
    @IdIgv INT
AS
BEGIN
    SELECT * FROM Igv
    WHERE IdIgv = @IdIgv
END;

-- SP Categoria
CREATE PROCEDURE sp_InsertarCategoria
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(100)
AS
BEGIN
    INSERT INTO Categoria (Nombre, Descripcion)
    VALUES (@Nombre, @Descripcion);
END;

CREATE PROCEDURE sp_ActualizarCategoria
    @IdCategoria INT,
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(100)
AS
BEGIN
    UPDATE Categoria
    SET Nombre = @Nombre, Descripcion = @Descripcion
    WHERE IdCategoria = @IdCategoria;
END;

CREATE PROCEDURE sp_EliminarCategoria
    @IdCategoria INT
AS
BEGIN
    DELETE FROM Categoria
    WHERE IdCategoria = @IdCategoria;
END;

CREATE PROCEDURE sp_SeleccionarTodasCategorias
AS
BEGIN
    SELECT * FROM Categoria;
END;

CREATE PROCEDURE sp_SeleccionarCategoriaPorId
    @IdCategoria INT
AS
BEGIN
    SELECT * FROM Categoria
    WHERE IdCategoria = @IdCategoria;
END;

-- SP Promocion
CREATE PROCEDURE sp_InsertarPromocion
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(100),
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    INSERT INTO Promocion (Nombre, Descripcion, FechaInicio, FechaFin)
    VALUES (@Nombre, @Descripcion, @FechaInicio, @FechaFin);
END;

CREATE PROCEDURE sp_ActualizarPromocion
    @IdPromocion INT,
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(100),
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    UPDATE Promocion
    SET Nombre = @Nombre, Descripcion = @Descripcion, FechaInicio = @FechaInicio, FechaFin = @FechaFin
    WHERE IdPromocion = @IdPromocion;
END;

CREATE PROCEDURE sp_EliminarPromocion
    @IdPromocion INT
AS
BEGIN
    DELETE FROM Promocion
    WHERE IdPromocion = @IdPromocion;
END;

CREATE PROCEDURE sp_SeleccionarTodasPromociones
AS
BEGIN
    SELECT * FROM Promocion;
END;

CREATE PROCEDURE sp_SeleccionarPromocionPorId
    @IdPromocion INT
AS
BEGIN
    SELECT * FROM Promocion
    WHERE IdPromocion = @IdPromocion;
END;

-- SP Editorial

CREATE PROCEDURE sp_InsertarEditorial
    @Nombre VARCHAR(100)
AS
BEGIN
    INSERT INTO Editorial (Nombre)
    VALUES (@Nombre);
END;

CREATE PROCEDURE sp_ActualizarEditorial
    @IdEditorial INT,
    @Nombre VARCHAR(100)
AS
BEGIN
    UPDATE Editorial
    SET Nombre = @Nombre
    WHERE IdEditorial = @IdEditorial;
END;

CREATE PROCEDURE sp_EliminarEditorial
    @IdEditorial INT
AS
BEGIN
    DELETE FROM Editorial
    WHERE IdEditorial = @IdEditorial;
END;

CREATE PROCEDURE sp_SeleccionarTodasEditoriales
AS
BEGIN
    SELECT * FROM Editorial;
END;

CREATE PROCEDURE sp_SeleccionarEditorialPorId
    @IdEditorial INT
AS
BEGIN
    SELECT * FROM Editorial
    WHERE IdEditorial = @IdEditorial;
END;

-- SP Direccion
CREATE PROCEDURE sp_InsertarDireccion
    @Departamento VARCHAR(100),
    @Provincia VARCHAR(100),
    @Distrito VARCHAR(100),
    @Calle VARCHAR(100)
AS
BEGIN
    INSERT INTO Direccion (Departamento, Provincia, Distrito, Calle)
    VALUES (@Departamento, @Provincia, @Distrito, @Calle);
END;

CREATE PROCEDURE sp_ActualizarDireccion
    @IdDireccion INT,
    @Departamento VARCHAR(100),
    @Provincia VARCHAR(100),
    @Distrito VARCHAR(100),
    @Calle VARCHAR(100)
AS
BEGIN
    UPDATE Direccion
    SET Departamento = @Departamento, Provincia = @Provincia, Distrito = @Distrito, Calle = @Calle
    WHERE IdDireccion = @IdDireccion;
END;

CREATE PROCEDURE sp_EliminarDireccion
    @IdDireccion INT
AS
BEGIN
    DELETE FROM Direccion
    WHERE IdDireccion = @IdDireccion;
END;

CREATE PROCEDURE sp_SeleccionarTodasDirecciones
AS
BEGIN
    SELECT * FROM Direccion;
END;

CREATE PROCEDURE sp_SeleccionarDireccionPorId
    @IdDireccion INT
AS
BEGIN
    SELECT * FROM Direccion
    WHERE IdDireccion = @IdDireccion;
END;

-- SP Metodo Pago
CREATE PROCEDURE sp_InsertarMetodoPago
    @Nombre VARCHAR(50)
AS
BEGIN
    INSERT INTO MetodoPago (Nombre)
    VALUES (@Nombre);
END;


CREATE PROCEDURE sp_ActualizarMetodoPago
    @IdMetodoPago INT,
    @Nombre VARCHAR(50)
AS
BEGIN
    UPDATE MetodoPago
    SET Nombre = @Nombre
    WHERE IdMetodoPago = @IdMetodoPago;
END;

CREATE PROCEDURE sp_EliminarMetodoPago
    @IdMetodoPago INT
AS
BEGIN
    DELETE FROM MetodoPago
    WHERE IdMetodoPago = @IdMetodoPago;
END;

CREATE PROCEDURE sp_SeleccionarTodosMetodosPago
AS
BEGIN
    SELECT * FROM MetodoPago;
END;

CREATE PROCEDURE sp_SeleccionarMetodoPagoPorId
    @IdMetodoPago INT
AS
BEGIN
    SELECT * FROM MetodoPago
    WHERE IdMetodoPago = @IdMetodoPago;
END;

-- SP Rol
CREATE PROCEDURE sp_InsertarRol
    @Nombre VARCHAR(100)
AS
BEGIN
    INSERT INTO Rol (Nombre)
    VALUES (@Nombre);
END;

CREATE PROCEDURE sp_ActualizarRol
    @IdRol INT,
    @Nombre VARCHAR(100)
AS
BEGIN
    UPDATE Rol
    SET Nombre = @Nombre
    WHERE IdRol = @IdRol;
END;

CREATE PROCEDURE sp_EliminarRol
    @IdRol INT
AS
BEGIN
    DELETE FROM Rol
    WHERE IdRol = @IdRol;
END;

CREATE PROCEDURE sp_SeleccionarTodosRoles
AS
BEGIN
    SELECT * FROM Rol;
END;

CREATE PROCEDURE sp_SeleccionarRolPorId
    @IdRol INT
AS
BEGIN
    SELECT * FROM Rol
    WHERE IdRol = @IdRol;
END;



