-- EJEMPLO JOIN
-- Dos tablas. En una tabla guardaremos capacidades (cosas que saben hacer) de personas, 
-- y en la otra anotaremos datos de personas. 

CREATE TABLE capacidad(
  codigo varchar2(4),
  nombre varchar2(20),
  PRIMARY KEY(codigo)
);
CREATE TABLE persona(
  codigo varchar2(4),
  nombre varchar2(20),
  codcapac varchar2(4),
  PRIMARY KEY(codigo)
);
INSERT INTO capacidad VALUES('js','Progr.Javascript');
INSERT INTO capacidad VALUES('php','Progr.PHP');
INSERT INTO capacidad VALUES ('j','Progr.Java');
INSERT INTO capacidad VALUES  ('sql','Bases datos SQL');
 
INSERT INTO persona VALUES ('ju','Juan','js');
INSERT INTO persona VALUES   ('ja','Javier','php');
INSERT INTO persona VALUES   ('jo','Jose','perl');
INSERT INTO persona VALUES   ('je','Jesus','html');

SELECT * FROM capacidad;
SELECT * FROM persona;
-- Hay dos capacidades para las que no conocemos a ninguna persona; 
-- y existen dos personas que tienen capacidades sobre las que no tenemos ningÚn detalle.
-- Si mostramos las personas con sus capacidades de la forma que sabemos, solo aparecerán las parejas de persona 
-- y capacidad para las que existe persona y existe capacidad, es decir:
SELECT * FROM capacidad, persona WHERE persona.codcapac = capacidad.codigo;
-- Resumimos esta consulta, para mostrar solo los nombres, que son los datos que nos interesan:  
SELECT persona.nombre, capacidad.nombre FROM persona, capacidad WHERE persona.codcapac = capacidad.codigo; 
-- La orden "where" es obligatoria: si no indicamos esa condición, se mostrara el "producto cartesiano" 
-- de las dos tablas: todos los pares (persona, capacidad), aunque no est�n relacionados en nuestra base de datos:  
SELECT persona.nombre, capacidad.nombre FROM persona, capacidad;  
-- Con "join" podemos afinar c�mo queremos enlazar (en ingl�s, "join", unir) las tablas. Por ejemplo, si queremos ver todas 
-- las personas y todas las capacidades, aunque no est�n relacionadas, como en el ejemplo anterior, 
-- algo que no suele tener sentido en la pr�ctica, lo podr�amos hacer con un "cross join" (unir de forma cruzada):  
SELECT persona.nombre, capacidad.nombre FROM persona CROSS JOIN capacidad;
-- Si s�lo queremos ver los datos que coinciden en ambas tablas, lo que antes consegu�amos comparando los c�digos 
-- con un "where", tambi�n podemos usar un "inner join" (uni�n interior; se puede abreviar simplemente "join"):  
SELECT persona.nombre, capacidad.nombre
FROM persona INNER JOIN capacidad
ON persona.codcapac = capacidad.codigo;
-- Pero aqu� llega la novedad: si queremos ver todas las personas y sus capacidades (si existen), 
-- mostrando incluso aquellas personas para las cuales no tenemos constancia de ninguna capacidad, 
-- usar�amos un "left join" (uni�n por la izquierda, tambi�n se puede escribir "left outer join",
-- uni�n exterior por la izquierda, para dejar claro que se van a incluir datos que est�n s�lo en una de las dos tablas):  
SELECT persona.nombre, capacidad.nombre
FROM persona LEFT OUTER JOIN capacidad
ON persona.codcapac = capacidad.codigo;
-- Si queremos ver todas las capacidades, incluso aquellas para las que no hay detalles sobre personas, 
-- podemos escribir el orden de las tablas al rev�s en la consulta anterior, o bien usar "right join" (o "right outer join"): 
SELECT persona.nombre, capacidad.nombre
FROM persona RIGHT OUTER JOIN capacidad
ON persona.codcapac = capacidad.codigo;
-- El significado de "LEFT" y de "RIGHT" hay que buscarlo en la posici�n en la que se enumeran las tablas en el bloque "FROM".
-- As�, la �ltima consulta se puede escribir tambi�n como un LEFT JOIN si se indica la capacidad en segundo lugar (en la parte izquierda), as�:  
SELECT persona.nombre, capacidad.nombre
FROM capacidad LEFT OUTER JOIN persona
ON persona.codcapac = capacidad.codigo;  