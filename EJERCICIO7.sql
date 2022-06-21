/*LENGUAJE DE MANIPULACIÓN DE DATOS: DML*/
CREATE TABLE EMPLEADOS (
  COD       NUMBER(2)    PRIMARY KEY,
  NOMBRE    VARCHAR2(50) NOT NULL,
  LOCALIDAD VARCHAR2(50) DEFAULT '�cija',
  FECHANAC  DATE
);
INSERT INTO EMPLEADOS VALUES (1, 'Pepe', 'Osuna', '01/01/1970');
INSERT INTO EMPLEADOS VALUES (2, 'Juan', DEFAULT, NULL);
INSERT INTO EMPLEADOS VALUES (3, 'Sara', NULL, NULL);
INSERT INTO EMPLEADOS(NOMBRE, COD) VALUES ('Ana', 5);

SELECT * FROM EMPLEADOS;

CREATE TABLE SOLICITANTES (
  NUM        NUMBER(2) PRIMARY KEY,
  NOMBRE     VARCHAR2(50),
  CIUDAD     VARCHAR2(50),
  NACIMIENTO DATE,
  ESTUDIOS   VARCHAR2(50)
);

INSERT INTO SOLICITANTES(NUM,NOMBRE,CIUDAD,NACIMIENTO,ESTUDIOS) VALUES (11,'Ana','Lugo','01/01/1999','ASIR-Gestion Base de Datos');
INSERT INTO SOLICITANTES(NUM,NOMBRE,CIUDAD,NACIMIENTO,ESTUDIOS) VALUES (22,'Ana','Lugo','01/01/1999','DAM-Base de Datos');
SELECT * FROM SOLICITANTES;

/*Insertaremos el 2º registro de SOLICITANTES en EMPLEADOS pero para que no haya claves duplicadas le asigno el num registro 22*/
INSERT INTO EMPLEADOS
SELECT NUM, NOMBRE, CIUDAD, NACIMIENTO
FROM SOLICITANTES
WHERE ESTUDIOS='DAM-Base de Datos';

SELECT * FROM EMPLEADOS;

INSERT INTO EMPLEADOS(FECHANAC, NOMBRE, COD)
SELECT NACIMIENTO, NOMBRE, NUM
FROM SOLICITANTES
WHERE ESTUDIOS='ASIR-Gestion Base de Datos';

SELECT * FROM EMPLEADOS;

-- Ponemos todos los nombres a may�sculas
-- y todas las localidades a Estepa
UPDATE EMPLEADOS
SET NOMBRE=UPPER(NOMBRE), LOCALIDAD='Santiago de Compostela';

SELECT * FROM EMPLEADOS;

-- Para los empleados que nacieron a partir de 1970
-- ponemos nombres con inicial may�scula y localidades Lugo
UPDATE EMPLEADOS
SET NOMBRE=INITCAP(NOMBRE), LOCALIDAD='Lugo'
WHERE FECHANAC >= '01/01/1970';

SELECT * FROM EMPLEADOS;

-- Actualizaci�n de datos usando una subconsulta
-- Aumenta un 10% el sueldo de los empleados que est�n dados de alta en la secci�n llamada Producci�n.
-- Suponiendo, que hubi�se una tabla relacionada con EMPLEADOS llamada secciones 
UPDATE empleados
SET sueldo=sueldo*1.10
WHERE id_seccion = (SELECT id_seccion FROM secciones
                    WHERE nom_seccion='Producci�n');
                    
-- Borramos empleados de Estepa
DELETE EMPLEADOS WHERE LOCALIDAD='Lugo';

SELECT * FROM EMPLEADOS;

-- Borramos empleados cuya fecha de nacimiento sea anterior a 1970
-- y localidad sea Osuna
DELETE EMPLEADOS WHERE FECHANAC < '01/01/1970' AND LOCALIDAD = 'Osuna';

-- Borramos TODOS los empleados;
DELETE EMPLEADOS; 