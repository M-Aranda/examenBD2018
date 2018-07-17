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

INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(200,200,300000)
INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(202,202,100000)
INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(204,204,300000)
INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(206,206,260000)
INSERT INTO complemento (codigo_vehiculo, codigo_opcion, precio) VALUES(208,208,300000)
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

CREATE PROCEDURE proc_factura (@codigoV INT, @rutDelCliente INT) AS -- DROP PROCEDURE proc_factura
	BEGIN
	DECLARE @precioSinIva INT
	DECLARE @precioConIva INT
	DECLARE @precioComplemento INT
	DECLARE @precioFinal INT

	SET @precioSinIva=(SELECT precio FROM vehiculo_nuevo WHERE codigo=@codigoV)
	SET @precioConIva=@precioSinIva+((@precioSinIva*19)/100)
	SET @precioComplemento=(SELECT complemento.precio FROM complemento WHERE complemento.codigo_vehiculo=@codigoV)
	SET @precioFinal=@precioConIva+@precioComplemento

	SELECT cliente.rutC AS 'Rut Cliente', cliente.nombreC AS 'Nombre cliente', cliente.direccion AS 'Direccion',
	cliente.telefono AS 'Telefono', venta.fecha AS 'Fecha de venta', vendedor.nombre AS 'Vendedor',
	vehiculo_nuevo.codigo AS 'Codigo vehiculo',vehiculo_nuevo.marca AS 'Marca', vehiculo_nuevo.modelo AS 'Modelo',
	vehiculo_nuevo.cilindrada AS 'Cilindrada', vehiculo_nuevo.precio AS 'Precio del vehiculo',
	opcion.nombre AS 'Opcion', @precioComplemento AS 'Precio Complemento', @precioFinal AS 'Precio Final' FROM cliente, vendedor, complemento, vehiculo_nuevo, venta, opcion
	WHERE cliente.rutC=venta.rut_cliente AND vendedor.rut=venta.rut_vendedor AND vehiculo_nuevo.codigo=complemento.codigo_vehiculo
	AND complemento.codigo_opcion=opcion.codigo AND vehiculo_nuevo.codigo=@codigoV AND cliente.rutC=@rutDelCliente

	END
GO

-- EXEC proc_factura 200,'20'


CREATE FUNCTION [dbo].[aumentarPrecioModelo](@mode VARCHAR(20), @porc INT)-- DROP FUNCTION aumentarPrecioModelo
RETURNS INT
AS
BEGIN
DECLARE @sql varchar(4000), @cmd varchar(4000), @num INT, @aumento INT,
 @nuevoPrecioDeVehiculo INT, @precioDeEsteVehiculo INT, @codigoV INT 
DECLARE aumentaPrecios CURSOR

		FOR(SELECT precio, codigo FROM vehiculo_nuevo WHERE modelo=@mode)
		OPEN aumentaPrecios

		FETCH NEXT FROM aumentaPrecios INTO @precioDeEsteVehiculo, @codigoV
			SET @aumento=(@precioDeEsteVehiculo*@porc)/100
			SET @nuevoPrecioDeVehiculo=@precioDeEsteVehiculo+@aumento
	
		SET @sql='UPDATE  vehiculo_nuevo SET precio= ' + CONVERT(VARCHAR,@nuevoPrecioDeVehiculo)  + ' WHERE modelo= (''' + @mode + ''') AND codigo=' + CONVERT(VARCHAR,@codigoV)  + ''
		SELECT @cmd = 'sqlcmd -S ' + @@servername +
              ' -d ' + db_name() + ' -Q "' + @sql + '"'
	EXEC master..xp_cmdshell @cmd, 'no_output'

		WHILE @@FETCH_STATUS=0
		BEGIN
			FETCH NEXT FROM aumentaPrecios INTO @precioDeEsteVehiculo, @codigoV
			SET @aumento=(@precioDeEsteVehiculo*@porc)/100
			SET @nuevoPrecioDeVehiculo=@precioDeEsteVehiculo+@aumento
			SET @sql='UPDATE  vehiculo_nuevo SET precio= ' + CONVERT(VARCHAR,@nuevoPrecioDeVehiculo)  + ' WHERE modelo= (''' + @mode + ''') AND codigo=' + CONVERT(VARCHAR,@codigoV)  + ''
SELECT @cmd = 'sqlcmd -S ' + @@servername +
              ' -d ' + db_name() + ' -Q "' + @sql + '"'
EXEC master..xp_cmdshell @cmd, 'no_output'
		END

CLOSE aumentaPrecios
DEALLOCATE aumentaPrecios
RETURN 1
END
GO

-- SELECT dbo.aumentarPrecioModelo ('Deportivo',10)
-- SELECT * FROM vehiculo_nuevo

CREATE TABLE VENTAS_EJECUTIVAS (
id INT IDENTITY (1,1),
rutVendedor VARCHAR (10),
nombreVendedor VARCHAR (70),
valorVehiculo INT,
comisionRealizada INT,
FOREIGN KEY (rutVendedor) REFERENCES vendedor(rut),
PRIMARY KEY (id)
)


CREATE TRIGGER comisionDeVenta ON venta AFTER INSERT, DELETE AS -- DROP TRIGGER comisionDeVenta

DECLARE @idVentaMasReciente INT
DECLARE @rutVend VARCHAR (10)
DECLARE @nomVend VARCHAR (70)
DECLARE @valorVehiculo INT
DECLARE @comision INT

DECLARE @rowcount int
SET @rowcount = @@rowcount
DECLARE @boletaBorrada INT
SET @boletaBorrada=@rowcount


BEGIN
    SET NOCOUNT ON;
    DECLARE @action as char(1);

    SET @action = 'I'; 
    IF EXISTS(SELECT * FROM DELETED)
    BEGIN
        SET @action = 
            CASE
                WHEN EXISTS(SELECT * FROM INSERTED) THEN 'U' 		
                ELSE 'D'    
            END
    END
    ELSE 
        IF NOT EXISTS(SELECT * FROM INSERTED) RETURN;
    END

IF @action='I'
SET @idVentaMasReciente=(SELECT MAX(id) FROM venta)

SET @rutVend=(SELECT venta.rut_vendedor FROM venta, vendedor WHERE venta.rut_vendedor=vendedor.rut AND venta.id=@idVentaMasReciente)
SET @nomVend=(SELECT vendedor.nombre FROM venta, vendedor WHERE venta.rut_vendedor=vendedor.rut AND venta.id=@idVentaMasReciente)
SET @valorVehiculo=(SELECT vehiculo_nuevo.precio FROM venta, vehiculo_nuevo WHERE venta.codigo_vehiculo=vehiculo_nuevo.codigo AND venta.id=@idVentaMasReciente)
SET @comision=(@valorVehiculo*5)/100

INSERT INTO VENTAS_EJECUTIVAS VALUES (@rutVend, @nomVend, @valorVehiculo, @comision)

IF @action='D'
DELETE FROM VENTAS_EJECUTIVAS WHERE id=@boletaBorrada
GO


CREATE TABLE EVENTOS(
ID INT IDENTITY(1,1),
fechaYHoraDeEvento DATETIME,
tipoDeEvento VARCHAR(200),
usuario VARCHAR (50),
PRIMARY KEY (id)
)
GO


CREATE TRIGGER registraEventos ON vehiculo_nuevo AFTER INSERT, DELETE, UPDATE
AS 
BEGIN
    SET NOCOUNT ON;
    DECLARE @action as char(1);

    SET @action = 'I'; 
    IF EXISTS(SELECT * FROM DELETED)
    BEGIN
        SET @action = 
            CASE
                WHEN EXISTS(SELECT * FROM INSERTED) THEN 'U' 		
                ELSE 'D'    
            END
    END
    ELSE 
        IF NOT EXISTS(SELECT * FROM INSERTED) RETURN;
    END

	IF @action='I' 
	INSERT INTO EVENTOS VALUES (CURRENT_TIMESTAMP,'Se agregaron datos', 'Administrador')
	ELSE IF @action='D'
	INSERT INTO EVENTOS VALUES (CURRENT_TIMESTAMP,'Se borraron datos', 'Administrador')
	ELSE IF @action='U'
	INSERT INTO EVENTOS VALUES (CURRENT_TIMESTAMP,'Se actualizaron datos', 'Administrador')
	GO




USE MASTER
GO
ALTER DATABASE examenBDMarcelo_Aranda
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE examenBDMarcelo_Aranda
GO

/*
SELECT * FROM View_Cliente_Usado
GO


CREATE TRIGGER borrarComisionVenta ON venta AFTER DELETE AS
DECLARE @rowcount int
SET @rowcount = @@rowcount
DECLARE @boletaBorrada INT
SET @boletaBorrada=@rowcount

DELETE FROM VENTAS_EJECUTIVAS WHERE id=@boletaBorrada
GO


EXEC sp_configure'xp_cmdshell', 1
GO
EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO


/*
CREATE FUNCTION [dbo].[_tmp_func](@mode VARCHAR(20))
RETURNS INT
AS
BEGIN
DECLARE @sql varchar(4000), @cmd varchar(4000)
SELECT @sql = 'UPDATE  vehiculo_nuevo SET precio=1 WHERE modelo= (''' + @mode + ''') '
SELECT @cmd = 'sqlcmd -S ' + @@servername +
              ' -d ' + db_name() + ' -Q "' + @sql + '"'
EXEC master..xp_cmdshell @cmd, 'no_output'
RETURN 1
END
GO

SELECT dbo._tmp_func ('Deportivo')
*/





CREATE FUNCTION [dbo].[_tmp_func](@mode VARCHAR(20))-- DROP FUNCTION _tmp_func
RETURNS INT
AS
BEGIN
DECLARE @sql varchar(4000), @cmd varchar(4000), @num INT
SET @num=2
SET @sql='UPDATE  vehiculo_nuevo SET precio= ' + CONVERT(VARCHAR,@num)  + ' WHERE modelo= (''' + @mode + ''') '
SELECT @cmd = 'sqlcmd -S ' + @@servername +
              ' -d ' + db_name() + ' -Q "' + @sql + '"'
EXEC master..xp_cmdshell @cmd, 'no_output'
RETURN 1
END
GO

SELECT dbo._tmp_func ('Deportivo')






Este no servia
CREATE FUNCTION [dbo].[aumentarPrecioModelo] (@porc INT, @modeloAAumentar VARCHAR (20)) RETURNS INT AS -- DROP FUNCTION dbo.aumentarPrecioModelo 
		
	BEGIN
		DECLARE @precioDeEsteVehiculo INT
		DECLARE @nuevoPrecioDeVehiculo INT
		DECLARE @aumento INT
		DECLARE @query VARCHAR(4000)
		DECLARE @cmd VARCHAR (4000)
		DECLARE aumentaPrecios CURSOR 

		
		FOR(SELECT precio FROM vehiculo_nuevo WHERE modelo=@modeloAAumentar)
		OPEN aumentaPrecios

		FETCH NEXT FROM aumentaPrecios INTO @precioDeEsteVehiculo
			SET @aumento=(@precioDeEsteVehiculo*@porc)/100
			SET @nuevoPrecioDeVehiculo=@precioDeEsteVehiculo+@aumento


		SET @query='UPDATE  vehiculo_nuevo SET precio= ' + CONVERT(VARCHAR,@nuevoPrecioDeVehiculo)  + ' WHERE modelo= (''' + @query + ''') '
		SELECT @cmd = 'sqlcmd -S ' + @@servername +
              ' -d ' + db_name() + ' -Q "' + @query + '"'
		EXEC master..xp_cmdshell @cmd, 'no_output'	

		WHILE @@FETCH_STATUS=0
			FETCH NEXT FROM aumentaPrecios INTO @precioDeEsteVehiculo
			SET @aumento=(@precioDeEsteVehiculo*@porc)/100
			SET @nuevoPrecioDeVehiculo=@precioDeEsteVehiculo+@aumento
			
		SET @query='UPDATE  vehiculo_nuevo SET precio= ' + CONVERT(VARCHAR,@nuevoPrecioDeVehiculo)  + ' WHERE modelo= (''' + @query + ''') '
		SELECT @cmd = 'sqlcmd -S ' + @@servername +
              ' -d ' + db_name() + ' -Q "' + @query + '"'
		EXEC master..xp_cmdshell @cmd, 'no_output'	

		CLOSE aumentaPrecios
		DEALLOCATE aumentaPrecios

		
		EXEC sp_configure'xp_cmdshell', 1 
		RETURN 1

	END
GO


SELECT dbo.aumentarPrecioModelo (10,'Deportivo')
GO
*/