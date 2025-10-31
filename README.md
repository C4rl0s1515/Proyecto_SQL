# Proyecto_SQL

## 1. 🧠 Introducción

El presente documento recoge el trabajo realizado sobre una base de datos relacional del tipo “videoclub” utilizando PostgreSQL como sistema gestor.  
A partir de un diagrama proporcionado y de un conjunto de enunciados, se desarrolló un bloque de consultas SQL enfocadas a practicar:

- Importación de bases de datos

- Creación de diagramas

- Consultas básicas ( Select / From / Where / As ) .

- Consultas de Agregación ( Min / Max / Count / Sum / Avg / Stddev / Variance / Concat ) .

- Consultas de Ordenación y Agrupación (Order by / Limit / Offset / Group by / Having).

- Relaciones entre tablas ( Inner Join/ Left Join / Right Join / Cross Join / Full Join ).

- Subconsultas ( Where / Exist / Not Exist / Select / From ).

- Estructuras de datos persistentes ( Vistas ).

- Estructuras de datos temporales ( CTEs ).

## 2. 🎯 Objetivo principal

El objetivo de este ejercicio es:

- Comprender el modelo de datos facilitado (películas, actores, categorías, clientes, alquileres y pagos).

- Resolver los enunciados SQL propuestos sin modificar el esquema, usando únicamente consultas.

- Practicar consultas reales, como “número de alquileres por cliente”, “actores sin películas” o “películas por categoría”.

- Aplicar CTE (WITH) para los casos en que es necesario calcular primero un valor de referencia y despues reutilizarlo.

- Medir variabilidad sobre un atributo económico concreto empleando funciones estadísticas de PostgreSQL.

- Documentar el proceso de forma que cualquier otra persona pueda reproducir las consultas sobre la misma base de datos.

## 3. 🧱 Estructura del proyecto
 ```
 |------ Data # Archivo con los datos originales.
    |------ BBDD_Proyecto.sql # Datos originales.
 |------ Diagramas # Imagenes de los diagramas SQL. 
    |------ Diagrama_proyecto_lógica-public.png # Imagen del 1º diagrama.
    |------ Diagrama_proyecto_lógica2-public.png # Imagen del 2º diagrama.
 |------ SQL # Archivo con los datos sql.
    |------ Proyecto_logica.sql # Proyecto SQL realizado.
 |------ README.md # Descripción del proyecto. 
```
## 4. 🗃️ Descripción de las tablas

A partir de la información facilitada, las consultas giran en torno a unas pocas tablas principales y varias tablas puente. 

Actor :

- Clave primaria: actor_id

- Contiene los datos básicos de los intérpretes.

- Se relaciona con las películas a través de film_actor.

Film :

- Clave primaria: film_id, también aparece language_id y original_language_id, pero operativamente se usa film_id como identificador.

- Campos relevantes: title, description, length, rating, replacement_cost, language_id, original_language_id.

- Se relaciona con los actores mediante film_actor y con las categorías mediante film_category.

Film_actor :

- Clave primaria compuesta: actor_id, film_id.

- Es la tabla puente entre actores y películas. Cada fila indica que un actor participa en una película.

Category :

- Clave primaria: category_id.

- Lista cerrada de categorías (Action, Comedy, Animation, Music, etc.).

Film_category :

- Clave primaria compuesta: film_id, category_id.

- Tabla puente que permite que una película pertenezca a una o más categorías.

Language :

- Clave primaria: language_id.

- Se usa desde film para indicar idioma y, opcionalmente, idioma original.

Inventory :

- Clave primaria: inventory_id, también incluye film_id y store_id.

- Representa las copias físicas de una película disponibles para alquilar en una tienda.

Rental :

- Clave primaria: rental_id, también incluye inventory_id, staff_id.

- Registra cada alquiler real, enlaza con inventory y con customer.

Payment :

- Clave primaria dada: customer_id, staff_id, rental_id.

- Registra los pagos efectuados por los alquileres, es la base para saber cuánto “ha generado la empresa”.

Customer :

- Clave primaria: customer_id, también incluye store_id y address_id.

- Contiene los datos de los clientes que alquilan. 

- Se relaciona con rental y payment por customer_id. Usa address_id para su dirección y store_id para la tienda a la que pertenece.

Store :

- Clave primaria: store_id, también incluye manager_staff_id y address_id.

- Representa cada tienda. 

- Se relaciona con inventory, con staff y con customer.

Staff :

- Clave primaria: staff_id, también incluye address_id y store_ id

- Contiene los empleados de las tiendas. 

- Se relaciona con payment y con store.

Adrress :

- Clave primaria: address_id, también incluye city_id.

- Tabla de direcciones, la usan customer, staff y store, se relaciona con city mediante city_id.

City :

- Clave primaria: city_id, también incluye city_id.

- Catálogo de ciudades, se relaciona con address mediante city_id y con country por country_id.

Country :

- Clave primaria: country_id.

- Catálogo de países. Se relaciona con city mediante country_id.


## 5. 🛠️ Instalación y requisitos

Este proyecto utiliza DBeaver y PostgresSQL 13 o superior.

## 6. 📚 Recap Sesiones

### Sesión 1

- Creación de repositorio en Github.

- Creación del sistema de carpetas del repositorio.

- Creación del archivo Readme.

- Se añade los datos originales BBDD_Proyecto.sql

### Sesión 2

- Creación del Diagrama_proyecto_lógica.

- Creación del archivo SQL Proyecto_lógica.

- Realización del SQL Proyecto_lógica.
 
## Sesión 3

- Finalización de SQL Proyecto_lógica.

- Creacíon del Diagrama_Proyecto_lógica2.

- Redacción del Readme.

## 7. 📝 Resultados y conclusiones

Se ejecutaron consultas sobre todas las partes del modelo para cubrir todas las áreas del esquema: películas , actores , categorías, inventario, clientes, alquileres y pagos.

Se obtuvieron listados filtrados por atributos simples: clasificación, duración, idioma, texto en nombres y apellidos, rangos de ids.

Se resolvieron distintas consultas del negocio, como clientes que más gastan, clientes que han alquilado determinado número de películas distintas, películas disponibles y nº de copias,películas alquiladas por un cliente concreto.

Se trabajó con relaciones, usando las tablas puente y las claves primarias, actores por película, películas por categoría, actores que han actuado en una categoría concreta y actores que no han actuado en una categoría concreta.

Se aplicaron agregaciones y estadísticos para conocer mínimo, máximo, media, varianza y desviación estándar.

Se usaron CTE (WITH) para los casos con fecha de referencia.

Se comprobó el patrón de “ausencia de relación” con NOT EXISTS.

Se definieron elementos reutilizables con tablas temporales de alquileres por cliente y de películas alquiladas.

En conclusión el modelo obliga a entender y utilizar las tablas puente y las claves primarias para cualquier consulta.

El modelo está normalizado y obliga a pasar por tablas puente film_actor, film_category para la mayoría de las preguntas.

Las funciones agregadas y estadísticas incluidas en PostgreSQL (COUNT, AVG, MIN, MAX, VARIANCE, STDDEV) son suficientes para hacer análisis descriptivo básico directamente en SQL sin crear tablas nuevas.

El uso de CTE facilita las consultas con pasos intermedios y mejora la legibilidad cuando hay una fecha de referencia o un cálculo previo.

Varias consultas pueden devolver 0 filas no por error de SQL, sino porque los datos no cumplen la condición que se especifica.

El conjunto de consultas obtenido cubre casos de selección, filtrado, joins, agrupaciones, subconsultas, CTE, exclusiones y cálculo de métricas, por lo que sirve como base genérica de prácticas de SQL.

## 8. 🧩 Contribuciones
 - Cualquier contribucion es bien venida, si quiere colaborar en el proyecto, abre un pull request.

## 9. 👤 Autores 

- Carlos Hernando
- https://github.com/C4rl0s1515 