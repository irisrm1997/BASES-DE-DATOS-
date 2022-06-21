/*TABLAS*/
CREATE TABLE Datos_Ventas(
Tienda VARCHAR(15),
Ventas INTEGER,
Fecha  DATE);

CREATE TABLE Zonas(
Region VARCHAR(15),
Tienda VARCHAR(15));

/*INSERCION DATOS*/
INSERT INTO Datos_Ventas VALUES ('Lugo',200,'20/02/2013');
INSERT INTO Datos_Ventas VALUES ('Santiago',400,'17/02/2013');
INSERT INTO Datos_Ventas VALUES ('Orense',800,'25/02/2013');
INSERT INTO Datos_Ventas VALUES ('Ferrol',700,'27/02/2013');
INSERT INTO Datos_Ventas VALUES ('Vigo',400,'28/02/2013');
INSERT INTO Datos_Ventas VALUES ('Santiago',1000,'18/02/2013');

INSERT INTO Zonas VALUES ('Zona vieja','Lugo');
INSERT INTO Zonas VALUES ('Casco antiguo','Orense');
INSERT INTO Zonas VALUES ('Area Central','Santiago');
INSERT INTO Zonas VALUES ('Zona portuaria','Vigo');

/*CONSULTAS*/
/*Mostraremos el nombre de todas las tiendas de la tabla Datos_Ventas.*/
SELECT Tienda FROM Datos_Ventas;
/* Mostraremos el nombre de todas las tiendas de la tabla Datos_Ventas. Sin repeticiones*/
SELECT DISTINCT Tienda FROM Datos_Ventas;
/*Mostraremos el nombre de todas las tiendas de la tabla Datos_Ventas CUYAS VENTAS SEAN MAYORES QUE 900.*/
SELECT Tienda FROM Datos_Ventas WHERE Ventas >900;
/*Mostraremos el nombre de todas las tiendas de la tabla Datos_Ventas CUYAS VENTAS SON MAYORES A 900 Ó CON VENTAS COMPRENDIDAS ENTRE 300 y 450 (dos condiciones compuestas)*/
SELECT tienda FROM datos_ventas WHERE ventas >900  OR (Ventas<450 AND Ventas>300);
/*Mostraremos datos de tiendas "Lugo o Santiago" de la tabla Datos_Ventas con IN*/
SELECT * FROM Datos_Ventas WHERE Tienda IN('Lugo', 'Santiago'); /*in = cualquiera de los miembros entre paréntesis*/
/*Mostraremos datos de tiendas cuyo nombre contenga la letra g (con LIKE)*/
SELECT * FROM Datos_Ventas WHERE Tienda LIKE '%g%';
/*Mostraremos datos de tiendas ordenadas descendentemente por ventas(con ORDER BY)*/
SELECT * FROM Datos_Ventas ORDER BY Ventas DESC;
/*Mostraremos datos de tiendas ordenadas ascendentemente por ventas y dentro de ellas, ordenado descendentemente por fecha(con ORDER BY)*/
SELECT * FROM Datos_Ventas ORDER BY Ventas ASC, Fecha DESC;

/*REHACEMOS TABLAS*/
DROP TABLE Datos_Ventas;
DROP TABLE Zonas;

CREATE TABLE Datos_Ventas(
Tienda VARCHAR(15),
Ventas INTEGER,
Fecha  DATE);

CREATE TABLE Zonas(
Region VARCHAR(15),
Tienda VARCHAR(15));

/*INSERTAMOS DATOS*/
INSERT INTO Datos_Ventas VALUES ('Lugo',200,'20/02/2013');
INSERT INTO Datos_Ventas VALUES ('Santiago',400,'17/02/2013');
INSERT INTO Datos_Ventas VALUES ('Orense',800,'25/02/2013');
INSERT INTO Datos_Ventas VALUES ('Ferrol',700,'27/02/2013');
INSERT INTO Datos_Ventas VALUES ('Vigo',400,'28/02/2013');
INSERT INTO Datos_Ventas VALUES ('Santiago',1000,'18/02/2013');

INSERT INTO Zonas VALUES ('Zona vieja','Lugo');
INSERT INTO Zonas VALUES ('Casco antiguo','Orense');
INSERT INTO Zonas VALUES ('Area Central','Santiago');
INSERT INTO Zonas VALUES ('Zona portuaria','Vigo');

/*Mostraremos la suma total de ventas.*/
SELECT SUM(Ventas) FROM Datos_Ventas;
/*Mostraremos el número de filas de la tabla Datos_Ventas.*/
SELECT COUNT(Tienda) FROM Datos_Ventas;
SELECT COUNT(DISTINCT Tienda) FROM Datos_Ventas;
/*Mostraremos las ventas agrupadas por tiendas.*/
SELECT Tienda, SUM(Ventas) FROM Datos_Ventas GROUP BY Tienda;
/*Mostraremos las ventas agrupadas por tiendas cuyas ventas sean mayores de 700.*/
SELECT Tienda, SUM(Ventas) FROM Datos_Ventas GROUP BY Tienda HAVING SUM(Ventas)>700;
/*Mostraremos ventas m�ximas de las tiendas agrupadas por nombre.*/
SELECT Tienda, MAX(Ventas) FROM Datos_Ventas GROUP BY Tienda;
/*Mostraremos la suma de ventas totales de las tiendas agrupadas de Santiago.*/
SELECT Tienda, SUM(Ventas) FROM Datos_Ventas GROUP BY Tienda HAVING Tienda='Santiago';
/* Mostraremos las ventas m�ximas de tiendas agrupadas por su nombre.*/
SELECT Tienda, MAX(Ventas) FROM Datos_Ventas GROUP BY Tienda;
/*Mostraremos datos de tiendas y suma de ventas agrupadas por iguales valores de tienda y ventas. Y en la segunda instrucción para las ventas igual a 1000.*/
SELECT Tienda, SUM(Ventas) FROM Datos_Ventas GROUP BY Tienda, Ventas;
SELECT Tienda, SUM(Ventas) FROM Datos_Ventas GROUP BY Tienda, Ventas HAVING Ventas=1000;