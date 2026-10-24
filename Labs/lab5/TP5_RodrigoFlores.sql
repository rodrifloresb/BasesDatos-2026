
-- 1
/*
Cree una tabla de `directors` con las columnas: Nombre,
Apellido, Número de Películas.
*/
create table directors (
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    NroPeliculas INT
);

-- 2
/*
El top 5 de actrices y actores de la tabla `actors` que 
tienen la mayor experiencia (i.e. el mayor número 
de películas filmadas) son también directores de las 
películas en las que participaron. 
Basados en esta información, inserten, utilizando una 
subquery los valores correspondientes en la tabla `directors`
*/

INSERT INTO directors(Nombre, Apellido, NroPeliculas)
SELECT sub.first_name, sub.last_name, sub.total_films
FROM (
    SELECT fa.actor_id, actor.first_name, actor.last_name, COUNT(fa.film_id) AS total_films
    FROM film_actor AS fa
    JOIN actor ON actor.actor_id = fa.actor_id
    GROUP BY fa.actor_id
    ORDER BY total_films DESC
    LIMIT 5
) AS sub;

-- 3
/*
Agregue una columna `premium_customer` que tendrá un valor 
'T' o 'F' de acuerdo a si el cliente es "premium" o no.
 Por defecto ningún cliente será premium
*/
ALTER TABLE customer
ADD COLUMN premium_customer VARCHAR(100) DEFAULT "F";

-- 4 
/*
Modifique la tabla customer. Marque con 'T' en 
la columna `premium_customer` de los 10 clientes
con mayor dinero gastado en la plataforma
*/

UPDATE customer
SET premium_customer = 'T'
WHERE customer_id IN (
    SELECT customer_id FROM (
        SELECT p.customer_id
        FROM payment AS p
        GROUP BY p.customer_id
        ORDER BY SUM(p.amount) DESC
        LIMIT 10
    ) AS top_customers
);

