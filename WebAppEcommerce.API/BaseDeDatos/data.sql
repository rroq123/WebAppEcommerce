-- Metodo Pago
INSERT INTO MetodoPago (Nombre) VALUES ('Débito'),('Crédito'),('PayPal');

-- IGV
INSERT INTO Igv (Valor, Fecha) VALUES (0.18, GETDATE());

-- Rol
INSERT INTO Rol (Nombre) VALUES ('Administrador'), ('Cliente');

-- Departamento
INSERT INTO Departamento(Nombre) VALUES ('Arequipa');

-- Provincia
INSERT INTO Provincia(IdDepartamento, Nombre) 
VALUES 
	(1,'Arequipa'),(1,'Camaná'),(1,'Caravelí'),(1,'Castilla'),
	(1,'Caylloma'),(1,'Condesuyos'),(1,'Islay'),(1,'La Unión');

-- Distrito
--Arequipa
INSERT INTO Distrito(IdProvincia, Nombre) 
VALUES
	(1, 'Arequipa'), (1, 'Alto Selva Alegre'), (1, 'Cayma'), (1, 'Cerro Colorado'),	
	(1, 'Characato'), (1, 'Chiguata'), (1, 'Jacobo Hunter'), (1, 'José Luis Bustamante y Rivero'),	
	(1, 'La Joya'), (1, 'Mariano Melgar'), (1, 'Miraflores'), (1, 'Mollebaya'), (1, 'Paucarpata'), 	
	(1, 'Pocsi'), (1, 'Polobaya '), (1, 'Quequeña'), (1, 'Sabandía'), (1, 'Sachaca'), (1, 'San Juan de Siguas'), 	
	(1, 'San Juan de Tarucani'), (1, 'Santa Isabel de Siguas'), (1, 'Santa Rita de Siguas'), (1, 'Socabaya'),
	(1, 'Tiabaya'), (1, 'Uchumayo'), (1, 'Vitor'), (1, 'Yanahuara'), (1, 'Yarabamba'), (1, 'Yura');
	
-- Camana
INSERT INTO Distrito(IdProvincia, Nombre) 
VALUES
	(2,'Camaná'), (2,'José María Quimper'),(2,'Mariano Nicolás Valcarcel'),
	(2,'Mariscal Cáceres'), (2,'Nicolás de Piérola'), (2,'Ocoña'),(2,'Quilca'),
	(2,'Samuel Pastor')

-- Caravelí
INSERT INTO Distrito(IdProvincia, Nombre) 
VALUES
	(3,'Caravelí'), (3,'Acarí'), (3,'Atico'), (3,'Atiquipa'),
	(3,'Bella Unión'), (3,'Cahuacho'), (3,'Chala'), (3,'Cháparra'),
	(3,'Huanuhuanu'), (3,'Jaquí'), (3,'Lomas'), (3,'Quicacha'), (3,'Yauca');


-- Castilla
INSERT INTO Distrito(IdProvincia, Nombre) 
VALUES	
	(4,'Aplao'), (4,'Andahua'), (4,'Ayo'), (4,'Chachas'), (4,'Chilcaymarca'),
	(4,'Choco'), (4,'Huancarqui'), (4,'Machaguay'), (4,'Orcopampa'), (4,'Pampacolca'),
	(4,'Tipán'), (4,'Uñón'), (4,'Uraca'), (4,'Viraco');


-- Caylloma
INSERT INTO Distrito(IdProvincia, Nombre) 
VALUES	
	(5,'Achoma'),(5,'Cabanaconde'),(5,'Callalli'),(5,'Caylloma'),(5,'Chivay'),(5,'Coporaque'),
	(5,'Huambo'),(5,'Huanca'),(5,'Ichupampa'),(5,'Lari'),(5,'Lluta'),(5,'Maca'),(5,'Madrigal'),
	(5,'Majes'),(5,'San Antonio de Chuca'),(5,'Sibayo'),(5,'Tapay'),(5,'Tisco'),(5,'Tuti'),
	(5,'Yanque');

-- Condesuyos
INSERT INTO Distrito(IdProvincia, Nombre) 
VALUES	
	(6,'Chuquibamba'),(6,'Andaray'),(6,'Cayarani'),(6,'Chichas'),
	(6,'Iray'),(6,'Río Grande'),(6,'Salamanca'),(6,'Yanaquihua');

-- Islay
INSERT INTO Distrito(IdProvincia, Nombre) 
VALUES	
    (7,'Mollendo'),(7,'Cocachacra'),(7,'Deán Valdivia'),
    (7,'Islay'),(7,'Mejía'),(7,'Punta de Bombón');

-- La Unión
INSERT INTO Distrito(IdProvincia, Nombre) 
VALUES	
	(8,'Cotahuasi'),(8,'Alca'),(8,'Charcana'),(8,'Huaynacotas'),(8,'Pampamarca'),
	(8,'Puyca'),(8,'Quechualla'),(8,'Sayla'),(8,'Tauría'),(8,'Tomepampa'),	(8,'Toro');

-- Categoria
INSERT INTO Categoria (Nombre, Descripcion) 
VALUES 
	('Historia', 'Libros y textos relacionados con la historia'),
	('Literatura', 'Libros y textos de ficción y no ficción relacionados con la literatura');

-- Editorial
INSERT INTO Editorial (Nombre)
VALUES	
	('EDIMAT LIBROS'),('EDHASA'), 
	('DEBOLSILLO'), ('BOOKET'), ('LIBRERO'), 
	('INSTITUTO DE ESTUDIOS PERUANOS'), ('DEBATE')

-- Libro
INSERT INTO Libro (ISBN,Nombre,IdEditorial,IdCategoria,Stock,Imagen,AnioEdicion)
VALUES
	('978-6124463686','CRIMEN Y CASTIGO',3,2,10,'Default',2024),
	('978-8497945356','DRÁCULA',1,2,10,'Default',2021),
	('978-8435021999','LOS MISERABLES',2,2,10,'Default',2021),
	('978-6280003986','GRECIA PARA TODOS',4,1,10,'Default',2022),
	('978-9463594257','HISTORIA EN SEGUNDOS ',5,1,10,'Default',2020),
	('978-6123262600','PODER Y SOCIEDAD EN EL PERU CONTEMPORANEO',6,1,10,'Default',2024)

-- Precios
INSERT INTO Precios(IdLibro,Precio,Fecha)
VALUES
	(8,49.00,GETDATE()),
	(9,70.60,GETDATE()),
	(10,68.00,GETDATE()),
	(11,59.00,GETDATE()),
	(12,82.30,GETDATE()),
	(13,49.00,GETDATE())
