
-- Parte I
-- 1 
/*
Lista el nombre de la ciudad, nombre del país, región y 
forma de gobierno de las 10 ciudades más pobladas del mundo.
*/
SELECT city.Name , country.Name, country.Region, country.GovernmentForm 
FROM city 
JOIN country 
ON city.CountryCode = country.Code 
ORDER BY city.Population DESC 
LIMIT 10;

-- 2 
/*
Listar los 10 países con menor población del mundo, 
junto a sus ciudades capitales
*/
SELECT country.Name, city.Name
FROM country
JOIN city
ON country.Capital = city.ID
ORDER BY country.Population ASC
LIMIT 10;

-- 3 
/*
Listar el nombre, continente y todos los lenguajes 
oficiales de cada país. (Hint: habrá más de una fila 
por país si tiene varios idiomas oficiales)
*/
SELECT country.Name, country.Continent, countrylanguage.Language
FROM countrylanguage
JOIN country
ON country.Code = countrylanguage.CountryCode AND countrylanguage.IsOfficial = "T"
ORDER BY country.Name ASC;

-- 4
/*
Listar el nombre del país y nombre de capital,
 de los 20 países con mayor superficie del mundo
*/
SELECT country.Name, city.Name
FROM country
JOIN city
ON country.Capital = city.ID
ORDER BY country.SurfaceArea DESC
LIMIT 20;

-- 5 
/*
Listar las ciudades junto a sus idiomas oficiales 
(ordenado por la población de la ciudad) y el 
porcentaje de hablantes del idioma
*/
SELECT city.Name, countrylanguage.Language, countrylanguage.Percentage
FROM city
JOIN countrylanguage
ON city.CountryCode = countrylanguage.CountryCode
AND countrylanguage.IsOfficial = "T"
ORDER BY city.Population DESC;

-- 6
/*
Listar los 10 países con mayor población y los 10 países
 con menor población (que tengan al menos 100 habitantes) 
 en la misma consulta.
*/
(
SELECT Name, Population
FROM country
ORDER BY Population DESC
LIMIT 10
)
UNION
(
SELECT Name, Population
FROM country
WHERE Population > 100
ORDER BY Population ASC
LIMIT 10
);

-- 7
/*
Listar aquellos países cuyos lenguajes oficiales son el 
Inglés y el Francés (hint: no debería haber filas duplicadas).
*/
(
SELECT country.Name
FROM country
JOIN countrylanguage
ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.IsOfficial = "T"
AND countrylanguage.Language = "English" 
) INTERSECT (
SELECT country.Name
FROM country
JOIN countrylanguage
ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.IsOfficial = "T"
AND countrylanguage.Language = "French" 
);

-- 8 
/*
Listar aquellos países que tengan hablantes del Inglés 
pero no del Español en su población
*/
(
    SELECT country.Name
    FROM country
    JOIN countrylanguage
    ON countrylanguage.CountryCode = country.Code
    AND countrylanguage.Language = "English" 
) EXCEPT (
    SELECT country.Name
    FROM country
    JOIN countrylanguage
    ON countrylanguage.CountryCode = country.Code
    AND countrylanguage.Language != "Spanish" 
);


-- Parte II
-- 1. ¿Devuelven los mismos valores las 
--     siguientes consultas? ¿Por qué?  

SELECT city.Name, country.Name 
FROM city 
INNER JOIN country 
ON city.CountryCode = country.Code 
AND country.Name = 'Argentina'; 

SELECT city.Name, country.Name 
FROM city 
INNER JOIN country 
ON city.CountryCode = country.Code
WHERE country.Name = 'Argentina'; 

/*
    Si devuelve el mismo resultado.
    De la primera forma en el propio JOIN estas "filtrando".
    En la segunda "filtras" el resultado del JOIN.
*/

-- ¿Y si en vez de INNER JOIN fuera un LEFT JOIN? 
SELECT city.Name, country.Name 
FROM city 
LEFT JOIN country 
ON city.CountryCode = country.Code 
AND country.Name = 'Argentina'; 

SELECT city.Name, country.Name 
FROM city 
LEFT JOIN country 
ON city.CountryCode = country.Code 
WHERE country.Name = 'Argentina'; 

/*  En la primera juntas las tablas y relacionas las ciudades
    con Argentina y tambien tenes la que no se relacionan.
    Lo cual cambia el resultado de la consulta
*/