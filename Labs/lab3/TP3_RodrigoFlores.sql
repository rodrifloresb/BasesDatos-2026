
-- Parte I
-- 1 
SELECT city.Name , country.Name, country.Region, country.GovernmentForm 
FROM city 
JOIN country 
ON city.CountryCode = country.Code 
ORDER BY city.Population DESC 
LIMIT 10;

-- 2 
SELECT country.Name, city.Name
FROM country
JOIN city
ON country.Capital = city.ID
ORDER BY country.Population ASC
LIMIT 10;

-- 3 
SELECT country.Name, country.Continent, countrylanguage.Language
FROM countrylanguage
JOIN country
ON country.Code = countrylanguage.CountryCode AND countrylanguage.IsOfficial = "T"
ORDER BY country.Name ASC;

-- 4
SELECT country.Name, city.Name
FROM country
JOIN city
ON country.Capital = city.ID
ORDER BY country.SurfaceArea DESC
LIMIT 20;

-- 5 
SELECT city.Name, countrylanguage.Language, countrylanguage.Percentage
FROM city
JOIN countrylanguage
ON city.CountryCode = countrylanguage.CountryCode
AND countrylanguage.IsOfficial = "T"
ORDER BY city.Population DESC;

-- 6
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
(
SELECT country.Name, countrylanguage.Language
FROM country
JOIN countrylanguage
ON countrylanguage.CountryCode = country.Code
AND countrylanguage.IsOfficial = "T"
AND countrylanguage.Language = "English" 
) UNION (
SELECT country.Name, countrylanguage.Language
FROM country
JOIN countrylanguage
ON countrylanguage.CountryCode = country.Code
AND countrylanguage.IsOfficial = "T"
AND countrylanguage.Language = "French" 
);

-- 8 
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