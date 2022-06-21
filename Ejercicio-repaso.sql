CREATE TABLE fabricante (
  codigo NUMBER PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo NUMBER  PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio FLOAT NOT NULL,
  codigo_fabricante INT NOT NULL,
  CONSTRAINT fabr_prod_FK FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Port�til Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Port�til Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

/*CONSULTAS REPASO*/
/*1.Lista el nombre de todos los productos que hay en la tabla producto.*/
SELECT nombre
FROM producto;

/*2.Lista los nombres y los precios de todos los productos de la tabla producto.*/
SELECT nombre, precio
FROM producto;

/*3.Lista todas las columnas de la tabla producto.*/
SELECT *
FROM producto;

/*4.Lista el nombre de los productos, el precio en euros y el precio en dólares 
estadounidenses (USD).*/
SELECT Nombre, precio AS Precio_Euros, precio * 1.09 AS Precio_Dolar 
FROM producto; 

/*5.Lista el nombre de los productos, el precio en euros y el precio en dólares 
estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, 
euros, dólares.*/
SELECT Nombre AS Nombre_de_producto, precio AS Euros , Precio * 1.09 AS Dolares 
FROM producto;

/*6. Lista los nombres y los precios de todos los productos de la tabla producto, 
convirtiendo los nombres a mayúscula.*/
SELECT UPPER (nombre), precio
FROM producto;

/*7. Lista los nombres y los precios de todos los productos de la tabla producto, 
convirtiendo los nombres a minúscula.*/
SELECT LOWER (nombre), precio
FROM producto;

/*8.Lista el nombre de todos los fabricantes en una columna, y en otra columna 
obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.*/
SELECT nombre , UPPER(SUBSTR(nombre,1,2)) AS nombre_FA 
FROM fabricante;

/*9. Lista los nombres y los precios de todos los productos de la tabla producto, 
redondeando el valor del precio.*/
SELECT nombre, ROUND (precio)
FROM producto;

/*10.Lista los nombres y los precios de todos los productos de la tabla producto, 
truncando el valor del precio para mostrarlo sin ninguna cifra decimal.*/
SELECT nombre, TRUNC((precio),0)
FROM producto;

/*11. Lista el código de los fabricantes que tienen productos en la tabla producto.*/
SELECT codigo_fabricante
FROM producto;

/*12. Lista el código de los fabricantes que tienen productos en la tabla producto, 
eliminando los códigos que aparecen repetidos.*/
SELECT DISTINCT (codigo_fabricante)
FROM producto;

/*13. Lista los nombres de los fabricantes ordenados de forma ascendente.*/
SELECT nombre 
FROM fabricante 
ORDER BY nombre ASC;

/*14.Lista los nombres de los fabricantes ordenados de forma descendente.*/
SELECT nombre 
FROM fabricante 
ORDER BY nombre DESC;

/*15.Lista los nombres de los productos ordenados en primer lugar por el 
nombre de forma ascendente y en segundo lugar por el precio de forma descendente.*/
SELECT nombre, precio 
FROM producto
ORDER BY nombre ASC, precio DESC;

/*16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.*/
SELECT *
FROM fabricante
WHERE rownum <= 5;

/*17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. 
La cuarta fila también se debe incluir en la respuesta.*/
SELECT * 
FROM (SELECT * FROM fabricante WHERE ROWNUM <= 5 ORDER BY ROWNUM DESC)
WHERE ROWNUM<=2 ORDER BY codigo;
/*mas correcto...*/
SELECT * FROM (SELECT nombre, ROWNUM AS rnum
FROM (SELECT * FROM fabricante ORDER BY codigo)
WHERE ROWNUM <= 5) WHERE rnum >= 4; 

/*18. Lista el nombre y el precio del producto más barato. 
(Utilice solamente las cláusulas ORDER BY y LIMIT es para MySQL)*/
SELECT nombre, precio
FROM producto
WHERE precio = (SELECT MIN(precio) FROM producto)
/*otra forma*/
SELECT * FROM
 (SELECT nombre, precio
 FROM producto 
 ORDER BY precio ASC)
WHERE ROWNUM <= 1;

/*19. Lista el nombre y el precio del producto más caro. 
(Utilice solamente las cláusulas ORDER BY y LIMIT es para MySQL)*/
SELECT nombre, precio
FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto)
/*otra forma*/
SELECT * FROM
 (SELECT nombre, precio
 FROM producto
 ORDER BY precio DESC)
WHERE ROWNUM <= 1;

/*20. Lista el nombre de todos los productos del 
fabricante cuyo código de fabricante es igual a 2.*/
SELECT nombre 
FROM producto 
WHERE codigo_fabricante=2;

/*21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.*/
SELECT nombre
FROM producto
WHERE precio <=120;

/*22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.*/
SELECT nombre
FROM producto
WHERE precio >=400;

/*23. Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.*/
SELECT nombre 
FROM producto
WHERE precio <=400;
--otra forma
SELECT nombre 
FROM producto 
WHERE NOT(precio >=400);
--otra forma
SELECT nombre
FROM producto
WHERE precio BETWEEN 0 AND 400;

/*24. Lista todos los productos que tengan un precio entre 80€ y 300€. 
Sin utilizar el operador BETWEEN.*/
SELECT nombre, precio 
FROM producto 
WHERE precio > 80 AND precio < 300;

/*25. Lista todos los productos que tengan un precio entre 60€ y 200€. 
Utilizando el operador BETWEEN.*/
SELECT nombre
FROM producto
WHERE precio BETWEEN 60 AND 200;

/*26. Lista todos los productos que tengan un precio mayor que 200€ y que el código de 
fabricante sea igual a 6.*/
SELECT nombre
FROM producto
WHERE precio >200 AND codigo_fabricante=6;
--otra forma
SELECT p.nombre, p.precio 
FROM producto p 
INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante 
WHERE f.codigo=6 AND p.precio > 200;

/*27. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar 
el operador IN.*/
SELECT nombre, codigo_fabricante
FROM producto
WHERE codigo_fabricante = '1'
OR codigo_fabricante ='3'
OR codigo_fabricante ='5'
--otra forma
SELECT p.nombre 
FROM producto p 
INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante 
WHERE f.codigo=1
OR f.codigo = 3 
OR f.codigo=5;

/*28. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el 
operador IN.*/
SELECT nombre, codigo_fabricante
FROM producto
WHERE codigo_fabricante IN ('1', '3', '5');
--otra forma
SELECT p.nombre 
FROM producto p 
INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante 
WHERE f.codigo IN (1,3,5);

/*29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 
el valor del precio). Cree un alias para la columna que contiene el precio que se llame 
céntimos.*/
SELECT nombre, precio * 100 AS céntimos
FROM producto;

/*30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.*/
SELECT nombre
FROM fabricante
WHERE nombre 
LIKE 'S%'
OR nombre LIKE 's%'; 
--otra forma
SELECT nombre 
FROM fabricante 
WHERE (SUBSTR(nombre,1,1)='S'
OR SUBSTR(nombre,1,1)= 's');

/*31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT nombre
FROM fabricante
WHERE nombre 
LIKE '%e';

/*32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.*/
SELECT nombre
FROM fabricante
WHERE nombre 
LIKE '%w%';

/*33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.*/
SELECT nombre
FROM fabricante
WHERE nombre 
LIKE '____';
--otra forma
SELECT nombre 
FROM fabricante 
WHERE LENGTH(nombre) = 4;

/*34. Devuelve una lista con el nombre de todos los productos que contienen la cadena 
Portátil en el nombre.*/
SELECT nombre
FROM producto
WHERE nombre
LIKE '%Port�til%';

/*35. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor
 en el nombre y tienen un precio inferior a 215 €.*/
SELECT nombre, precio
FROM producto
WHERE nombre
LIKE '%Monitor%' and precio<215;

/*36 Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 
180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo 
lugar por el nombre (en orden ascendente).*/
SELECT nombre, precio
FROM producto
WHERE precio >=180 
ORDER by precio DESC, nombre ASC;

/*4 Consultas multitabla (Composición interna):*/
/*1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos 
los productos de la base de datos.*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
--otra forma
SELECT producto.nombre AS Nombre_producto, producto.precio, fabricante.nombre AS Nombre_fabricante 
FROM producto,fabricante 
WHERE fabricante.codigo=producto.codigo_fabricante; 
-- También de otra forma:
SELECT producto.nombre, producto.precio, fabricante.nombre 
from producto 
INNER JOIN fabricante on producto.codigo_fabricante=fabricante.codigo;
 -- También de otra forma:
SELECT p.nombre, p.precio, f.nombre 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo;

/*2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los 
productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden 
alfabético.*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
ORDER by fabricante.nombre;
--OTRA FORMA
SELECT producto.nombre AS Nombre_producto,producto.precio, fabricante.nombre AS Nombre_fabricante 
FROM producto,fabricante 
WHERE fabricante.codigo=producto.codigo_fabricante 
ORDER BY fabricante.nombre ASC;
-- También de otra forma:
SELECT p.nombre, precio, f.nombre 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre ASC;
-- También de otra forma:
SELECT p.nombre, precio, f.nombre 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre ASC;
/*3. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y 
nombre del fabricante, de todos los productos de la base de datos.*/

SELECT producto.codigo, producto.nombre, producto.codigo_fabricante, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo

/*4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto 
más barato.*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON  producto.codigo_fabricante=fabricante.codigo
WHERE producto.precio = (SELECT MIN(precio) FROM producto);

/*5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto 
más caro.*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON  producto.codigo_fabricante=fabricante.codigo
WHERE producto.precio = (SELECT MAX(precio) FROM producto);

/*6. Devuelve una lista de todos los productos del fabricante Lenovo.*/
SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

/*7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio 
mayor que 200€.*/
SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
WHERE fabricante.nombre = 'Crucial';
AND producto.precio >200;

/*8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy 
Seagate. Sin utilizar el operador IN.*/
SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
WHERE fabricante.nombre = 'Asus'
OR fabricante.nombre = 'Hewlett-Packard'
OR fabricante.nombre = 'Seagate';

/*9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. 
Utilizando el operador IN.*/
SELECT producto.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

/*10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes 
cuyo nombre termine por la vocal e.*/
SELECT producto.nombre, producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
WHERE fabricante.nombre 
LIKE '%e';

/*11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de 
fabricante contenga el carácter w en su nombre.*/
SELECT producto.nombre, producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
WHERE fabricante.nombre 
LIKE '%w%';

/*12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos 
los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar 
por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
WHERE producto.precio >=180
ORDER BY producto.precio DESC, fabricante.nombre ASC;

/*13.Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos 
fabricantes que tienen productos asociados en la base de datos. */
SELECT producto.codigo, fabricante.nombre
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo;

/*5 Consultas multitabla (Composición externa):
Resuelve todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

1. Devuelve un listado de todos los fabricantes que existen en la base de datos, 
junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también 
aquellos fabricantes que no tienen productos asociados.*/
SELECT producto.nombre, fabricante.nombre
FROM producto
RIGHT JOIN fabricante
ON producto.codigo_fabricante=fabricante.codigo

/*2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún 
producto asociado.*/
SELECT fabricante.nombre
FROM producto
right JOIN fabricante
ON producto.codigo_fabricante=fabricante.codigo
WHERE producto.nombre is null

/*3. ¿Pueden existir productos que no estén relacionados con un fabricante? 
Justifica tu respuesta.*/


/*6 Consultas resumen:
1. Calcula el número total de productos que hay en la tabla productos.*/
SELECT COUNT(nombre)
FROM producto;

/*2. Calcula el número total de fabricantes que hay en la tabla fabricante.*/
SELECT COUNT(nombre)
FROM fabricante;

/*3. Calcula el número de valores distintos de código de fabricante aparecen en la tabla 
productos.*/
SELECT COUNT (DISTINCT codigo_fabricante)
FROM producto;

/*4. Calcula la media del precio de todos los productos.*/
SELECT AVG (precio)
FROM producto;

/*5. Calcula el precio más barato de todos los productos.*/
SELECT MIN (precio)
FROM producto;

/*6. Calcula el precio más caro de todos los productos.*/
SELECT MAX (precio)
FROM producto;

/*7. Lista el nombre y el precio del producto más barato.*/
SELECT nombre, precio
FROM producto
WHERE precio = (SELECT MIN(precio) FROM producto)

/*8.Lista el nombre y el precio del producto más caro.*/
SELECT nombre, precio
FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto)

/*9. Calcula la suma de los precios de todos los productos.*/
SELECT SUM (precio)
FROM producto;

/*10. Calcula el número de productos que tiene el fabricante Asus.*/
SELECT COUNT (fabricante.nombre)
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
WHERE fabricante.nombre = 'Asus';

/*11.Calcula la media del precio de todos los productos del fabricante Asus.*/
SELECT AVG (producto.precio)
FROM producto
JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo
WHERE fabricante.nombre = 'Asus';

/*12. Calcula el precio más barato de todos los productos del fabricante Asus.*/
SELECT MIN(producto.precio) 
FROM fabricante 
JOIN producto 
ON fabricante.codigo = producto.codigo_fabricante 
WHERE fabricante.nombre = 'Asus'

/*13. Calcula el precio más caro de todos los productos del fabricante Asus.*/
SELECT MAX(producto.precio) 
FROM fabricante 
JOIN producto 
ON fabricante.codigo = producto.codigo_fabricante 
WHERE fabricante.nombre = 'Asus'

/*14. Calcula la suma de todos los productos del fabricante Asus.*/
SELECT SUM(producto.precio) 
FROM fabricante 
JOIN producto 
ON fabricante.codigo = producto.codigo_fabricante 
WHERE fabricante.nombre = 'Asus'

/*15.Muestra el precio máximo, precio mínimo, precio medio y 
el número total de productos que tiene el fabricante Crucial.*/
SELECT MAX(producto.precio), 
  MIN(producto.precio), 
  AVG(producto.precio), 
  COUNT(producto.precio)
FROM fabricante 
JOIN producto 
ON fabricante.codigo = producto.codigo_fabricante 
WHERE fabricante.nombre = 'Crucial'

/*16. Muestra el número total de productos que tiene cada uno de los fabricantes. El listado 
también debe incluir los fabricantes que no tienen ningún producto. El resultado mostrará 
dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. 
Ordene el resultado descendentemente por el número de productos.*/
SELECT COUNT(producto.nombre) AS numero_productos, fabricante.nombre
FROM fabricante 
FULL JOIN producto 
ON producto.codigo_fabricante = fabricante.codigo
GROUP BY fabricante.nombre 
ORDER BY 1 DESC;

/*17. Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de 
los fabricantes. El resultado mostrará el nombre del fabricante junto con los datos que se 
solicitan.*/
SELECT MAX(producto.precio), MIN (producto.precio), AVG (producto.precio), fabricante.nombre
FROM fabricante 
FULL JOIN producto 
ON producto.codigo_fabricante = fabricante.codigo
GROUP BY fabricante.nombre;

/*18. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de 
los fabricantes que tienen un precio medio superior a 200€. No es necesario mostrar el nombre 
del fabricante, con el código del fabricante es suficiente*/
SELECT MAX(producto.precio), 
  MIN (producto.precio), 
  AVG (producto.precio), 
  fabricante.codigo
FROM fabricante 
JOIN producto 
ON producto.codigo_fabricante = fabricante.codigo
GROUP BY fabricante.codigo
HAVING AVG (producto.precio)>200;

/*19. Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio 
medio y el número total de productos de los fabricantes que tienen un precio medio superior 
a 200€. Es necesario mostrar el nombre del fabricante.*/
SELECT MAX(producto.precio), 
  MIN (producto.precio), 
  AVG (producto.precio), 
  COUNT(producto.nombre), 
  fabricante.nombre
FROM fabricante 
JOIN producto 
ON producto.codigo_fabricante = fabricante.codigo
GROUP BY fabricante.nombre
HAVING AVG (producto.precio)>200;

/*20. Calcula el número de productos que tienen un precio mayor o igual a 180€.*/
SELECT COUNT(codigo)
FROM producto
WHERE precio >=180;

/*21. Calcula el número de productos que tiene cada fabricante con un precio mayor
 o igual a 180€.*/
SELECT COUNT(producto.nombre)AS numero_productos, fabricante.nombre
FROM producto
JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo
WHERE precio >=180
GROUP BY fabricante.nombre;

/*22.Lista el precio medio los productos de cada fabricante, mostrando solamente el código 
del fabricante.*/
SELECT AVG(producto.precio), fabricante.codigo
FROM producto
JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo
GROUP BY fabricante.codigo;

/*23. Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre 
del fabricante.*/
SELECT AVG(producto.precio), fabricante.nombre
FROM producto
JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo
GROUP BY fabricante.nombre;

/*24. Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o 
igual a 150€.*/
SELECT AVG(producto.precio) AS precio_medio, fabricante.nombre
FROM producto
JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo
GROUP BY fabricante.nombre
HAVING AVG(producto.precio) >= 150

/*25. Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.*/
SELECT COUNT(producto.nombre) AS numero_productos, fabricante.nombre
FROM producto
JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo
GROUP BY fabricante.nombre
HAVING COUNT(producto.nombre)>=2;

/*26.Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene 
cada uno con un precio superior o igual a 220 €. No es necesario mostrar el nombre de los 
fabricantes que no tienen productos que cumplan la condición.
Resultado esperado

nombre       total
Lenovo        2
Asus          1
Crucial       1

*/
SELECT fabricante.nombre, COUNT(producto.nombre)
FROM producto
JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >=220
GROUP BY fabricante.nombre
ORDER BY 2 DESC, 1 ASC;

/*27. Devuelve un listado con los nombres de los fabricantes y el número de productos que 
tiene cada uno con un precio superior o igual a 220 €. El listado debe mostrar el nombre 
de todos los fabricantes, es decir, si hay algún fabricante que no tiene productos con un 
precio superior o igual a 220€ deberá aparecer en el listado con un valor igual a 0 en el 
número de productos.

Ejemplo del resultado esperado:

nombre           total
Lenovo            2
Crucial           1
Asus              1
Huawei            0
Samsung           0
Gigabyte          0
Hewlett-packard   0
Xiaomi            0
Seagate           0

Ver: https://www.w3schools.com/sql/sql_case.asp
*/
SELECT fabricante.nombre, COUNT
    (CASE WHEN producto.precio >= 220 THEN fabricante.nombre ELSE NULL END) AS total
FROM fabricante 
LEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.nombre
ORDER BY 2 DESC, 1 DESC;

/*28. Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos 
sus productos es superior a 1000 €.*/
SELECT fabricante.nombre
FROM fabricante
JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.nombre
HAVING SUM(producto.precio)>1000;

/*29. Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. 
El resultado debe tener tres columnas: nombre del producto, precio y nombre del fabricante. 
El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del 
fabricante.*/
SELECT producto.precio, producto.nombre, fabricante.nombre
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
AND producto.precio = 
(
  SELECT MAX(producto.precio)
  FROM producto
  where fabricante.codigo = producto.codigo_fabricante
)
ORDER BY 3 ASC;


/*7. SUBCONSULTAS (en la cláusula where)
7.1 Con operadores básicos de comparación:
1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT * 
FROM producto 
WHERE codigo_fabricante = 
  (SELECT codigo 
  FROM fabricante 
  WHERE nombre = 'Lenovo');

/*2.Devuelve todos los datos de los productos que tienen el mismo precio que el producto más 
caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
/*no hay dos productos con el mismo precio*/
SELECT * 
FROM producto 
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo')
AND precio = (SELECT MAX(precio) FROM producto WHERE nombre = 'Lenovo') ;

/*3. Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT nombre
FROM producto
WHERE precio = 
(SELECT MAX(precio) FROM producto WHERE codigo_fabricante =  
  (SELECT codigo from fabricante where nombre='Lenovo'));

/*4. Lista el nombre del producto más barato del fabricante Hewlett-Packard.*/
SELECT nombre
FROM producto
WHERE precio =
  (SELECT MIN (precio) FROM producto WHERE codigo_fabricante =
    (SELECT codigo FROM fabricante WHERE nombre='Hewlett-Packard'));

/*5. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al 
producto más caro del fabricante Lenovo.*/
SELECT nombre
FROM producto
WHERE precio >=
(SELECT MAX (precio) FROM producto wHERE codigo_fabricante =
(SELECT codigo FROM fabricante WHERE nombre='Lenovo'));

/*6. Lista todos los productos del fabricante Asus que tienen un precio superior al precio 
medio de todos sus productos.*/
SELECT nombre
FROM producto
WHERE precio >
  (SELECT AVG(precio) FROM producto WHERE codigo_fabricante =
    (SELECT codigo FROM fabricante WHERE nombre='Asus'));

/*7.2. Subconsultas con ALL y ANY:*/
/*7. 7. Subconsultas (En la cláusula HAVING). Devuelve un listado con todos los nombres de 
los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.*/
SELECT fabricante.nombre
FROM producto
JOIN FABRICANTE
ON  fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.nombre
HAVING COUNT(fabricante.nombre) = 
  (SELECT COUNT (nombre) FROM producto WHERE codigo_fabricante =
    (SELECT codigo FROM fabricante WHERE nombre='Lenovo'))

/*8.Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, 
ORDER BY ni LIMIT.*/
SELECT nombre
FROM producto
WHERE precio >= ALL(SELECT precio FROM producto);

/*9. Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, 
ORDER BY ni LIMIT.*/
SELECT nombre
FROM producto
WHERE precio <= ALL(SELECT precio FROM producto);

/*10. Devuelve los nombres de los fabricantes que tienen productos asociados. 
(Utilizando ALL o ANY).*/
SELECT nombre
FROM fabricante
WHERE codigo = ANY
  (SELECT codigo_fabricante
  FROM producto);

/*11.Devuelve los nombres de los fabricantes que no tienen productos asociados. 
(Utilizando ALL o ANY).*/
SELECT nombre
FROM fabricante
WHERE codigo <> all
  (SELECT codigo_fabricante
  FROM producto);

/*7.3 Subconsultas con IN y NOT IN:
12. Devuelve los nombres de los fabricantes que tienen productos asociados. 
(Utilizando IN o NOT IN).*/
SELECT Nombre
FROM fabricante
WHERE codigo IN 
  (SELECT codigo_fabricante 
  FROM producto);

/*13. Devuelve los nombres de los fabricantes que no tienen productos asociados. 
(Utilizando IN o NOT IN).*/
SELECT Nombre
FROM fabricante
WHERE codigo NOT IN 
  (SELECT codigo_fabricante 
  FROM producto);

/*7.4 Subconsultas con EXISTS y NOT EXISTS:*/

/*14. Devuelve los nombres de los fabricantes que tienen productos asociados. 
(Utilizando EXISTS o NOT EXISTS).*/
SELECT nombre
FROM fabricante
WHERE EXISTS 
  (SELECT codigo_fabricante
  FROM producto
  WHERE producto.codigo_fabricante = fabricante.codigo);

/*15.Devuelve los nombres de los fabricantes que no tienen productos asociados. 
(Utilizando EXISTS o NOT EXISTS).*/
SELECT nombre
FROM fabricante
WHERE NOT EXISTS 
  (SELECT codigo_fabricante
  FROM producto
  WHERE producto.codigo_fabricante = fabricante.codigo);

/*7.5 Subconsultas relacionadas:*/
/*16. Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.*/
SELECT fabricante.nombre, producto.nombre, producto.precio  
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
AND producto.precio = 
(
  SELECT MAX(producto.precio)
  FROM producto
  where fabricante.codigo = producto.codigo_fabricante
);

/*17. Devuelve un listado de todos los productos que tienen un precio mayor o igual a la 
media de todos los productos de su mismo fabricante.*/
SELECT producto.nombre
FROM producto
JOIN fabricante
ON fabricante.codigo = producto.codigo_fabricante
AND producto.precio >= 
(
  SELECT AVG(producto.precio)
  FROM producto
  where fabricante.codigo = producto.codigo_fabricante
);

/*18. Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT MAX(producto.precio) 
FROM fabricante 
JOIN producto 
ON fabricante.codigo = producto.codigo_fabricante 
WHERE fabricante.nombre = 'Lenovo'