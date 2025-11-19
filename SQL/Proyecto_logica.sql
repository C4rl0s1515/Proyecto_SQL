
-- 1º Crea el esquema de la BBDD.

-- 2º Muestra los nombres de todas las películas con una clasificación por edades de ‘R  

SELECT f.title AS "Titulo", F.rating AS "Calificación" 
FROM film AS f 
WHERE f.rating = 'R';

-- 3º Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40 

SELECT concat("first_name" , ' ', "last_name") AS "Nombre", a.actor_id AS "Id_actor"
FROM actor AS a	
WHERE	actor_id BETWEEN 30 AND 40
ORDER BY actor_id; 

-- 4º Obtén las películas cuyo idioma coincide con el idioma original 

SELECT f.title AS "Titulo"
FROM film AS f 
WHERE f.language_id = f.original_language_id ;

-- (No se obtiene ningun resultado porque la columna original_languaje esta vacia)

-- 5º Ordena las películas por duración de forma ascendente 

SELECT f.title AS "Titulo" , f.length AS "Duración" 
FROM film AS f 
ORDER BY f.length ASC ;

-- 6º Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido

SELECT concat( a.first_name , ' ', a.last_name ) AS "Nombre"
FROM	actor AS a 
WHERE a.last_name = 'ALLEN' ;

-- 7º Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento

SELECT "rating" AS "Calificación" , COUNT(film_id) AS "Total_peliculas"
FROM	film 
GROUP BY "rating" 
ORDER BY "Total_peliculas" ASC ;

-- 8º Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.

SELECT f.title AS "Titulo", f.rating AS "Calificación" , f.length AS "Duración" 
FROM film AS f 
WHERE f.length > 180 OR f.rating = 'PG-13'
ORDER BY "Titulo" ;

-- 9º Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT MIN(replacement_cost) AS min_coste, MAX(replacement_cost) AS max_coste, ROUND(AVG(replacement_cost),2) AS avg_coste, ROUND(VARIANCE(replacement_cost),2) AS var_coste, ROUND(STDDEV(replacement_cost),2) AS stddev_coste
FROM film;


-- 10º Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT MAX(f.length ) AS "Mayor_duración" , MIN(f.length ) AS "Menor_duración"
FROM film AS f ;

-- 11º Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT r.rental_id AS "Id_alquiler", p.amount AS "Coste", r.rental_date AS "Fecha_alquiler" 
FROM rental AS r
INNER JOIN payment AS p 
	ON r.rental_id = p.rental_id
ORDER BY r.rental_date DESC, r.rental_id DESC 
LIMIT 1 OFFSET 2 ;

-- 12º Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.

SELECT f.title AS "Titulo", f.rating AS "Calificación"
FROM film AS f 
WHERE f.rating NOT IN ('NC-17' , 'G')
ORDER BY "Calificación";

-- 13º Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT f.rating AS "Calificación", round(AVG(f.length),2) AS "Duración_media" 
FROM film AS f 
GROUP BY "Calificación"
ORDER BY "Calificación" ;

-- 14º Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT f.title AS "Titulo", f.length AS "Duración"
FROM film AS f 
WHERE f.length > 180
ORDER BY "Duración" ;

-- 15º ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM(p.amount ) AS "Dinero_total_generado"
FROM payment AS p ;

-- 16º Muestra los 10 clientes con mayor valor de id.

SELECT c.customer_id AS "Id_Cliente"
FROM	customer AS c
ORDER BY "Id_Cliente" DESC 
LIMIT 10  ;

-- 17º Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.

SELECT concat( a.first_name , ' ', a.last_name) AS "Nombre", f.title AS "Titulo"
FROM	actor AS a 
INNER	JOIN film_actor AS fa  
	ON a.actor_id = fa.actor_id 
INNER JOIN film AS f 
	ON fa.film_id = f.film_id 
WHERE f.title = 'EGG IGBY'
ORDER BY "Nombre" ;

-- 18º Selecciona todos los nombres de las películas únicos.

SELECT f.title AS "Titulo"
FROM	film AS f 
GROUP BY f.title
ORDER BY f.title ;

-- 19º Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

SELECT f.title AS "Titulo", f.length as "Duración", c."name" AS "Categoria"
FROM film as f
INNER JOIN film_category as fc
	ON fc.film_id = f.film_id
INNER JOIN category as c 
	ON c.category_id = fc.category_id
WHERE c.name = 'Comedy' AND f."length" > 180
ORDER BY f.title;

-- 20º Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

SELECT c."name" AS "Categoria", ROUND(AVG(f."length"),2) AS "Duración" 
FROM film AS f 
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN	category AS c 
ON c.category_id = fc.category_id 
GROUP BY c."name" 
HAVING AVG(f."length") > 110  
ORDER BY "Categoria" ;

-- 21º ¿Cuál es la media de duración del alquiler de las películas? 

SELECT AVG(r.return_date - r.rental_date) AS "Tiempo_medio_alquiler"
FROM rental AS r ;

-- 22º Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT concat(a.first_name , ' ', A.last_name) AS "Nombre_y_Apellidos"
FROM actor AS a 
ORDER BY "Nombre_y_Apellidos" ;

-- 23º Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT DATE("rental_date") AS "Dia", COUNT(*) AS "total_alquileres"
FROM rental AS r 
GROUP BY "Dia"
ORDER BY total_alquileres DESC, "Dia";

-- 24º Encuentra las películas con una duración superior al promedio.

SELECT title AS "Titulo", length AS "Duración"
FROM film 
WHERE length > (SELECT AVG(length)
FROM film )
ORDER BY length ASC, title ;

SELECT ROUND(AVG(length),2)
FROM film ;

-- 25º Averigua el número de alquileres registrados por mes.

SELECT date_trunc('month' ,r.rental_date) AS "Mes_alquiler", count(r.rental_date ) AS "Nº_alquileres"
FROM rental AS r 
GROUP BY "Mes_alquiler" 
ORDER BY "Mes_alquiler" ASC ;

-- 26º Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT ROUND(AVG(p.amount),2) AS "Media_Total_pagado", ROUND(stddev(p.amount),2) AS "Desviación_estadar_Total_pagado", ROUND(variance(p.amount),2) AS "Varianza_Total_pagado"
FROM payment AS p ; 

-- 27º ¿Qué películas se alquilan por encima del precio medio?

SELECT title AS "Titulo" , rental_rate AS "Precio_Alquiler" 
FROM film  
WHERE rental_rate > (SELECT AVG(rental_rate)
FROM film)
ORDER BY rental_rate ASC, title ;

SELECT AVG(rental_rate) AS "Precio_medio"
FROM	film;

-- 28º Muestra el id de los actores que hayan participado en más de 40 películas

SELECT actor_id , COUNT("film_id") AS "Número_de_peliculas"
FROM film_actor 
GROUP BY actor_id 
HAVING COUNT("film_id") > 40 
ORDER BY "Número_de_peliculas" DESC ;

-- 29º Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT f.title AS "Titulo", count(I.store_id ) AS "Cantidad_Disponible"
FROM inventory AS i 
INNER JOIN film AS f 
	ON i.film_id = f.film_id 
GROUP BY f.title  
ORDER BY f.title , "Cantidad_Disponible" DESC ;

-- 30º Obtener los actores y el número de películas en las que ha actuado.

SELECT concat(a.first_name, ' ', a.last_name) AS "Nombre_actores" , count(fa.film_id) AS "Número_peliculas"
FROM actor AS a 
INNER JOIN film_actor AS fa 
	ON a.actor_id = fa.actor_id 
GROUP BY "Nombre_actores" 
ORDER BY "Número_peliculas" DESC;

-- 31º Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

SELECT f.title AS "Titulo", concat(a.first_name , ' ', a.last_name) AS "Nombre_actores" 
FROM film AS f 
LEFT JOIN film_actor AS fa  
	ON f.film_id = fa.film_id 
LEFT JOIN actor AS a 
	ON a.actor_id = fa.actor_id  
ORDER BY "Titulo" ASC, "Nombre_actores" ;

-- 32º Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

SELECT concat(a.first_name , ' ', a.last_name) AS "Nombre_actores", f.title AS "Titulo"
FROM actor AS a 
LEFT JOIN film_actor AS fa 
	ON a.actor_id = fa.actor_id 
LEFT JOIN film AS f 
	ON fa.film_id = f.film_id 
ORDER BY "Nombre_actores" ASC, "Titulo" ;

-- 33º Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT f.title AS "Titulos", r.rental_date AS "Registro_alquiler", r.return_date AS "Registro_devolución"
FROM film AS f 
LEFT JOIN inventory AS i 
	ON f.film_id = I.film_id 
LEFT JOIN rental AS r 
	ON i.inventory_id = R.inventory_id 
ORDER BY f.title , r.rental_date ;

-- 34º Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT concat( c.first_name , ' ', c.last_name ) AS "Nombre_cliente", SUM(p.amount) AS "Gasto_total"
FROM customer AS c 
INNER JOIN payment AS p 
	ON p.customer_id  = c.customer_id
GROUP BY c.customer_id , "Nombre_cliente" 
ORDER BY "Gasto_total" desc 
LIMIT 5 ;

-- 35º Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT concat(a.first_name, ' ', a.last_name) AS "Nombre_actores"
FROM actor AS a 
WHERE a.first_name = 'JOHNNY';

-- 36º Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.

SELECT a.first_name AS "Nombre", a.last_name "Apellido"
FROM actor AS a 
ORDER BY "Nombre" ;

-- 37º Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MIN(a.actor_id ) AS "Id_más_Bajo", MAX(a.actor_id) AS "Id_más_Alto"
FROM actor AS a ;

-- 38º Cuenta cuántos actores hay en la tabla “actorˮ.

SELECT count(a.actor_id) AS "Número_de_Actores"
FROM actor AS a ;

-- 39º Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT concat(a.first_name, ' ', a.last_name) AS "Nombre_actores"
FROM actor AS a 
ORDER BY a.last_name ASC ;

-- 40º Selecciona las primeras 5 películas de la tabla “filmˮ.

SELECT f.title AS "Titulo", f.film_id AS "Identificardor_Pelicula"
FROM film AS f
ORDER BY "Titulo" ASC 
LIMIT	5;

-- 41º Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?.

SELECT a.first_name AS "Nombre", count(a.first_name) AS "Cantidad_actores_mismo_nombre"
FROM	actor AS a 
GROUP BY a.first_name 
ORDER BY "Cantidad_actores_mismo_nombre" DESC, "Nombre" ;

-- Hay 3 nombres que son los mas repetidos (JULIA/KENNETH/PENELOPE).

-- 42º Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT r.rental_date AS "Día_alquiler", r.return_date AS "Día_devolución", concat(c.first_name, ' ', c.last_name) AS "Nombre_cliente"
FROM customer AS c 
LEFT JOIN rental AS r 
	ON c.customer_id = r.customer_id 
GROUP BY "Nombre_cliente" , "Día_alquiler", "Día_devolución"
ORDER BY "Día_alquiler" ASC, "Nombre_cliente"; 

-- 43º Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT concat(c.first_name, ' ', c.last_name) AS "Nombre", r.rental_date AS "Día_alquiler", r.return_date AS "Día_decolución"
FROM customer AS c 
LEFT JOIN rental AS r 
	ON c.customer_id = r.customer_id
GROUP BY "Nombre", "Día_alquiler", "Día_decolución" 
ORDER BY "Nombre" , "Día_alquiler" ASC ;

-- 44º Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

SELECT *
FROM film AS f 
CROSS	JOIN	category AS c ;

-- No aporta ningún valor porque devuelve el producto cartesiano, es decir combina cada película con cada categoría incluso cuando no están relacionadas, esto generea información falsa porque no existe ningúna relación.

-- 45º Encuentra los actores que han participado en películas de la categoría 'Action'.

SELECT concat(a.first_name , ' ', a.last_name) AS "Actor" , c."name" AS "Categoria"
FROM actor AS a 
INNER	JOIN	film_actor AS fa 
	ON a.actor_id = fa.actor_id  
INNER JOIN film_category AS fc
	ON fa.film_id = fc.film_id 
INNER JOIN category AS c 
	ON fc.category_id = c.category_id
WHERE c."name" = 'Action'
GROUP BY "Actor" , "Categoria" 
ORDER BY "Actor" ;

-- 46º Encuentra todos los actores que no han participado en películas

SELECT concat(a.first_name , ' ', a.last_name) AS "Nombre"
FROM actor AS a 
WHERE NOT EXISTS (
    SELECT 1
    FROM film_actor as fa
    WHERE fa.actor_id = a.actor_id
    )
ORDER BY "Nombre" ;

-- No aparece ningún resultado lo que nos indica que todos los actores han aparecido por lo menos en una pelicula.

-- 47º Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT concat(a.first_name, ' ', a.last_name) AS "Nombre_actor", count(f.title) AS "Número_peliculas"
FROM actor AS a 
INNER	JOIN film_actor AS fa 
	ON A.actor_id = FA.actor_id 
INNER JOIN film AS f 
	ON fa.film_id = f.film_id 
GROUP BY "Nombre_actor", a.actor_id   
ORDER BY "Número_peliculas" DESC, "Nombre_actor" ;

-- 48º Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.

CREATE VIEW actor_num_peliculas AS
SELECT concat(a.first_name, ' ', a.last_name) AS "Nombre", count(f.title) AS "Número_peliculas"
FROM actor AS a 
INNER	JOIN film_actor AS fa 
	ON A.actor_id = FA.actor_id
INNER JOIN film AS f 
	ON fa.film_id = f.film_id 
GROUP BY "Nombre" 
ORDER BY "Nombre" ;

SELECT * FROM actor_num_peliculas 

-- 49º Calcula el número total de alquileres realizados por cada cliente.

SELECT concat(c.first_name, ' ', c.last_name) AS "Cliente", count(r.rental_date) AS "Número_alquileres"
FROM customer AS c 
LEFT JOIN rental AS r 
	ON c.customer_id = r.customer_id 
GROUP BY "Cliente" 
ORDER BY "Número_alquileres" DESC, "Cliente" ;

-- 50º Calcula la duración total de las películas en la categoría 'Action'.

SELECT c."name" AS "Categoria", SUM(f.length) AS "Duración"
FROM film AS f 
INNER	JOIN film_category AS fc 
	ON f.film_id = fc.film_id 
INNER JOIN category AS c 
	ON fc.category_id = c.category_id 
WHERE c.name = 'Action'
GROUP BY "Categoria" ;

-- 51º Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.

CREATE TEMPORARY TABLE cliente_rentas_temporal AS 
SELECT concat(c.first_name , ' ', c.last_name ) AS "Cliente", count(r.rental_id ) AS "Total_alquileres"
FROM rental AS r
INNER JOIN customer AS c
	ON r.customer_id = c.customer_id
GROUP BY "Cliente"
ORDER BY "Total_alquileres" DESC ;

SELECT *
FROM cliente_rentas_temporal;

-- 52º Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.

CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT f.title AS "Titulo", count(r.rental_id) AS "Nº_alquileres"
FROM rental AS r 
INNER	JOIN inventory AS i 
	ON r.inventory_id = i.inventory_id 
INNER JOIN film AS f 
	ON i.film_id = f.film_id 
GROUP BY "Titulo" 
HAVING count(r.rental_id ) >= 10
ORDER BY "Nº_alquileres" DESC ;

SELECT *
FROM peliculas_alquiladas;

-- 53º Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

SELECT f.title AS "Titulo" , concat(c.first_name ,' ', c.last_name) AS "Nombre_cliente", r.return_date AS "Día_devolución" 
FROM customer AS c 
INNER JOIN rental AS r 
	ON c.customer_id = r.customer_id
INNER	JOIN inventory AS i 
	ON r.inventory_id = i.inventory_id 
INNER JOIN film AS f 
	ON i.film_id = f.film_id 
WHERE concat(c.first_name ,' ', c.last_name) = 'TAMMY SANDERS'
AND r.return_date IS NULL 
GROUP BY "Titulo" , "Nombre_cliente" , "Día_devolución" 
ORDER BY "Titulo" ASC ;

-- 54º Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.

SELECT concat(a.first_name , ' ', a.last_name) AS "Nombre_actor", c."name" AS "Categoria"
FROM actor AS a 
INNER JOIN film_actor AS fa 
	ON a.actor_id = fa.actor_id
INNER JOIN film_category AS fc 
	ON fa.film_id = fc.film_id 
INNER JOIN category AS c 
	ON fc.category_id = c.category_id 
WHERE c."name" = 'Sci-Fi'
GROUP BY "Nombre_actor" , "Categoria" , a.last_name 
ORDER BY a.last_name ;

-- 55º Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

WITH primera_fecha AS (
	SELECT MIN(r.rental_date) AS "primer_alquiler" 
	FROM rental AS r 
	INNER JOIN inventory AS i 
		ON r.inventory_id = i.inventory_id
	INNER	JOIN film AS f 
		ON i.film_id = f.film_id 
	WHERE f.title = 'SPARTACUS CHEAPER'
	),
actores_peliculas AS (
	SELECT a.first_name, a.last_name, r.rental_date
	FROM actor a
      INNER JOIN film_actor fa 
    		ON fa.actor_id = a.actor_id
      INNER JOIN film f        
    		ON f.film_id = fa.film_id
      INNER JOIN inventory i   
    		ON i.film_id = f.film_id
      INNER JOIN rental r      
    		ON r.inventory_id = i.inventory_id
    	)
SELECT ap.first_name AS "Nombre", ap.last_name AS "Apellido"
FROM actores_peliculas ap
INNER JOIN primera_fecha pf
        ON ap.rental_date > pf.primer_alquiler
GROUP BY ap.first_name, ap.last_name
ORDER BY ap.last_name ;

-- 56º Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.

SELECT concat(a.first_name , ' ', a.last_name ) AS "Nombre"
FROM actor AS a 
WHERE NOT EXISTS (
	SELECT 1
	FROM film_actor AS fa 
	INNER JOIN film_category AS fc 
		ON fa.film_id = fc. film_id 
	INNER JOIN category AS c 
		ON fc.category_id = c.category_id 
	WHERE a.actor_id = fa.actor_id 
	AND c."name" = 'Music'
	)
	ORDER BY "Nombre" ;

-- 57º Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

WITH días AS (
	SELECT f.title AS "Titulo", SUM(r.return_date::date  - r.rental_date::date ) AS "Días_alquiler" 
	FROM rental AS r
	INNER JOIN inventory AS i 
		ON r.inventory_id = i.inventory_id
	INNER	JOIN film AS f 
		ON i.film_id = f.film_id 
	GROUP BY f.title
	)
SELECT *
FROM días 
WHERE "Días_alquiler" > 8
ORDER BY "Días_alquiler" ASC , "Titulo" ;

-- 58º Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

SELECT f.title AS "Titulo", c.name  AS "Categoria"
FROM film AS f
INNER JOIN film_category fc 
	ON f.film_id = fc.film_id
INNER JOIN category c 
	ON c.category_id = fc.category_id
WHERE c.name = 'Animation'
GROUP BY f.title , c."name" 
ORDER BY f.title ;

-- 59º Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.

SELECT F.title AS "Titulo", f.length AS "Duración"
FROM film AS f 
WHERE f.length = (
	SELECT f.length 
	FROM film AS f
	WHERE f.title = 'DANCING FEVER'
	) 
ORDER BY "Titulo" ;

-- 60º Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

SELECT concat(c.first_name, ' ', c.last_name) AS "Nombre_cliente", count(f.film_id) AS "Número_alquileres"
FROM customer AS c 
INNER JOIN rental AS r 
	ON c.customer_id = r.customer_id 
INNER JOIN inventory AS i 
	ON r.inventory_id = i.inventory_id 
INNER JOIN film AS f 
	ON i.film_id = f.film_id
GROUP BY c.first_name , c.last_name  
HAVING count(f.film_id) >= 7
ORDER BY c.last_name ;

-- 61º Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT c."name" AS "Categoria", count(r.rental_id) AS "Recuento"
FROM category AS c 
INNER JOIN film_category AS fc 
	ON c.category_id = fc.category_id 
INNER JOIN inventory AS i 
	ON fc.film_id = i.film_id 
INNER JOIN rental AS r 
	ON i.inventory_id = r.inventory_id 
GROUP BY "Categoria" 
ORDER BY "Recuento" DESC ;

-- 62º Encuentra el número de películas por categoría estrenadas en 2006.

SELECT c."name" AS "Categoria", count(f.film_id) AS "Nº_peliculas_estrenadas"
FROM film AS f 
INNER JOIN film_category AS fc  
	ON f.film_id = fc.film_id 
INNER JOIN category AS c 
	ON fc.category_id = c.category_id 
WHERE f.release_year = '2006'
GROUP BY "Categoria" 
ORDER BY "Nº_peliculas_estrenadas" DESC ;

-- 63º Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT s.staff_id, concat(s.first_name, ' ',s.last_name) AS "Nombre_trabajador", st.store_id
FROM staff AS s 
CROSS JOIN store AS st ;

-- 64º Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT c.customer_id AS "Id_cliente", concat(c.first_name , ' ', c.last_name) AS "Nombre_cliente", count(r.rental_id) AS "Total_peliculas_alquiladas"  
FROM rental AS r 
INNER JOIN customer AS c 
	ON r.customer_id = c.customer_id
GROUP BY "Id_cliente" 
ORDER BY "Total_peliculas_alquiladas" DESC ;















