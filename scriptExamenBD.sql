CREATE DATABASE examenBDMarcelo_Aranda
GO

USE examenBDMarcelo_Aranda
GO

CREATE SEQUENCE incrementoEnParesOpcion
	START WITH 200
	INCREMENT BY 2;
GO

CREATE SEQUENCE incrementoEnParesRegistro
	START WITH 200
	INCREMENT BY 2;
GO

CREATE SEQUENCE incrementoEnParesVenta
	START WITH 200
	INCREMENT BY 2;
GO

CREATE SEQUENCE incrementoEnParesVehiculoNuevo
	START WITH 200
	INCREMENT BY 2;
GO

CREATE SEQUENCE incrementoEnParesComplemento
	START WITH 200
	INCREMENT BY 2;
GO

CREATE TABLE cliente(
rutC VARCHAR (10),
nombreC VARCHAR (70),
direccion VARCHAR (80),
telefono VARCHAR (20),
PRIMARY KEY(rutC)
)
GO


CREATE TABLE vendedor(
rut VARCHAR (10),
nombre VARCHAR (70),
direccion VARCHAR (80),
telefono VARCHAR (20),
PRIMARY KEY (rut)
)
GO

CREATE TABLE vehiculo_usado(
patenteU VARCHAR (6),
marcaU VARCHAR (20),
modeloU VARCHAR (30),
precio_tasacionU INT,
PRIMARY KEY(patenteU)
)
GO


CREATE TABLE opcion(
codigo INT DEFAULT NEXT VALUE FOR incrementoEnParesOpcion,
nombre VARCHAR (30),
descripcion VARCHAR (200) 
PRIMARY KEY(codigo)
)
GO


CREATE TABLE vehiculo_nuevo(
codigo INT DEFAULT NEXT VALUE FOR incrementoEnParesVehiculoNuevo,
marca VARCHAR (30),
modelo VARCHAR (20),
cilindrada INT,
precio INT,
PRIMARY KEY(codigo)
)
GO

CREATE TABLE registro(
id INT DEFAULT NEXT VALUE FOR incrementoEnParesRegistro,
patente VARCHAR (6),
rut VARCHAR (10),
fecha_cesion DATE,
FOREIGN KEY (rut) REFERENCES cliente (rutC),
FOREIGN KEY (patente) REFERENCES vehiculo_usado (patenteU),
PRIMARY KEY(id)
)
GO


CREATE TABLE complemento(
id INT DEFAULT NEXT VALUE FOR incrementoEnParesComplemento,
codigo_vehiculo INT,
codigo_opcion INT,
precio INT,
FOREIGN KEY (codigo_vehiculo) REFERENCES vehiculo_nuevo (codigo),
FOREIGN KEY (codigo_opcion) REFERENCES opcion (codigo),
PRIMARY KEY(id)
)
GO


CREATE TABLE venta(
id INT DEFAULT NEXT VALUE FOR incrementoEnParesVenta,
rut_cliente VARCHAR(10),
rut_vendedor VARCHAR (10),
codigo_vehiculo INT,
fecha DATE,
FOREIGN KEY(rut_cliente) REFERENCES cliente (rutC),
FOREIGN KEY(rut_vendedor) REFERENCES vendedor (rut),
FOREIGN KEY (codigo_vehiculo) REFERENCES vehiculo_nuevo (codigo),
PRIMARY KEY (id)
)
GO



INSERT INTO cliente VALUES ('20','Don Juan','Puerto Magallanes','95867777')
INSERT INTO cliente VALUES ('30','Don Pedro','Puerto Magallanes','95867777')
INSERT INTO cliente VALUES ('40','Felipe','Puerto Magallanes','95867777')
INSERT INTO cliente VALUES ('10','Sofia','Puerto Magallanes','95867777')
INSERT INTO cliente VALUES ('70','Macarena','Puerto Magallanes','95867777')
GO

INSERT INTO vendedor VALUES ('22','Jaime','Puerto Magallanes','95867777')
INSERT INTO vendedor VALUES ('33','Gloria','Puerto Magallanes','95867777')
INSERT INTO vendedor VALUES ('44','Sandra','Puerto Magallanes','95867777')
INSERT INTO vendedor VALUES ('11','Maria','Puerto Magallanes','95867777')
INSERT INTO vendedor VALUES ('13','Geronimo','Puerto Magallanes','95867777')
GO


INSERT INTO vehiculo_usado VALUES ('FKUI99', 'Ford','Deportivo', 2000000)
INSERT INTO vehiculo_usado VALUES ('FKUI11', 'Ford','Fino', 2000000)
INSERT INTO vehiculo_usado VALUES ('FKUI22', 'Toyota','Deportivo', 3000000)
INSERT INTO vehiculo_usado VALUES ('FKUI33', 'Ford','Clasico', 2000000)
INSERT INTO vehiculo_usado VALUES ('FKUI44', 'Susuki','Deportivo', 1000000)
GO

INSERT INTO opcion (nombre, descripcion) VALUES ('Aire acondicionado premium','Posee lo ultimo en tecnologia de aire acondicionado')
INSERT INTO opcion (nombre, descripcion) VALUES ('Encendedores rapidos','Posee lo ultimo en tecnologia para fumadores')
INSERT INTO opcion (nombre, descripcion) VALUES ('Bolsas de aires de lujo','Posee lo ultimo en tecnologia de seguridad')
INSERT INTO opcion (nombre, descripcion) VALUES ('Wi fi','Da wi fi')
INSERT INTO opcion (nombre, descripcion) VALUES ('Reproductor de blue ray','Posible reproducir blue rays')
GO


INSERT INTO vehiculo_nuevo (marca, modelo, cilindrada, precio) VALUES ('Ford', 'Deportivo', 4, 2900500)
INSERT INTO vehiculo_nuevo (marca, modelo, cilindrada, precio) VALUES ('Susuki', 'Deportivo', 3, 1500500)
INSERT INTO vehiculo_nuevo (marca, modelo, cilindrada, precio)  VALUES ('Toshiba', 'Deportivo', 2, 3500500)
INSERT INTO vehiculo_nuevo (marca, modelo, cilindrada, precio)  VALUES ('Ford', 'Deportivo', 4, 2700500)
INSERT INTO vehiculo_nuevo (marca, modelo, cilindrada, precio)  VALUES ('Ford', 'Deportivo', 1, 2600500)
GO

INSERT INTO registro (patente, rut, fecha_cesion) VALUES ('FKUI99','20',GETDATE())
INSERT INTO registro (patente, rut, fecha_cesion) VALUES ('FKUI11','30',GETDATE())
INSERT INTO registro (patente, rut, fecha_cesion) VALUES ('FKUI22','40',GETDATE())
INSERT INTO registro (patente, rut, fecha_cesion) VALUES ('FKUI33','10',GETDATE())
INSERT INTO registro (patente, rut, fecha_cesion)  VALUES ('FKUI44','70',GETDATE())
GO

INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(200,200,3000000)
INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(202,202,3000000)
INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(204,204,3000000)
INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(206,206,3000000)
INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(208,208,3000000)
GO

INSERT INTO venta (rut_cliente,rut_vendedor, codigo_vehiculo, fecha) VALUES ('20','22',200,GETDATE())
INSERT INTO venta(rut_cliente,rut_vendedor, codigo_vehiculo, fecha) VALUES ('30','33',202,GETDATE())
INSERT INTO venta (rut_cliente,rut_vendedor, codigo_vehiculo, fecha) VALUES ('40','44',204,GETDATE())
INSERT INTO venta (rut_cliente,rut_vendedor, codigo_vehiculo, fecha) VALUES ('10','11',206,GETDATE())
INSERT INTO venta (rut_cliente,rut_vendedor, codigo_vehiculo, fecha) VALUES ('70','13',208,GETDATE())
GO

CREATE VIEW View_Cliente_Usado AS
SELECT cliente.nombreC AS 'Nombre del cliente', cliente.rutC AS 'Rut del cliente',
vehiculo_usado.marcaU AS 'Marca del vehiculo usado', vehiculo_usado.modeloU AS 'Modelo del vehiculo usado', 
vehiculo_usado.patenteU AS 'Patente del vehiculo usado', vehiculo_usado.precio_tasacionU AS 'Precio de tasacion del vehiculo usado' ,
vehiculo_nuevo.codigo AS 'Codigo del vehiculo nuevo', vehiculo_nuevo.marca AS 'Marca del vehiculo nuevo', 
vehiculo_nuevo.modelo AS 'Modelo del vehiculo nuevo', vehiculo_nuevo.cilindrada AS 'Cilindrada del vehiculo nuevo',
vehiculo_nuevo.precio AS 'Precio del vehiculo nuevo' FROM vehiculo_usado, registro, cliente,
venta, vehiculo_nuevo WHERE registro.patente=vehiculo_usado.patenteU AND registro.rut=cliente.rutC AND 
venta.rut_cliente=cliente.rutC AND venta.codigo_vehiculo=vehiculo_nuevo.codigo
GO

/*
SELECT * FROM View_Cliente_Usado
GO
*/

USE MASTER
GO
ALTER DATABASE examenBDMarcelo_Aranda
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE examenBDMarcelo_Aranda
GO
