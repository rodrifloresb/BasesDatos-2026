-- Parte I
-- 1 
/*
Listar el nombre de la ciudad y el nombre del país de 
todas las ciudades que pertenezcan a países con una 
población menor a 10000 habitantes
*/
SELECT city.Name, country.Name
FROM city
JOIN country
ON city.CountryCode = country.Code
AND country.Population < 10000
ORDER BY country.Name ASC;

-- 2
/*
Listar todas aquellas ciudades cuya población sea mayor 
que la población promedio entre todas las ciudades.
*/
SELECT city.Name, country.Name
FROM city
JOIN country
ON city.CountryCode = country.Code
WHERE country.Population > (
    SELECT avg(Population) FROM country
)
ORDER BY country.Name ASC;

-- 3
/*
Listar todas aquellas ciudades no asiáticas cuya 
población sea igual o mayor a la población total 
de algún país de Asia 
*/ 
SELECT city.Name, country.Name
FROM city
JOIN country
ON  city.CountryCode = country.Code
AND country.Continent != "Asia"
WHERE country.Population >= (
    SELECT min(Population)
    FROM country
    WHERE continent = "Asia"
)
ORDER BY country.Name ASC;

-- 4
/*
Listar aquellos países junto a sus idiomas no oficiales,
que superen en porcentaje de hablantes a cada uno de los
idiomas oficiales del país.
*/
SELECT c.Name, c.Code, countrylanguage.Language
FROM country AS c
JOIN countrylanguage
ON countrylanguage.CountryCode = c.Code
AND countrylanguage.IsOfficial = "F"
WHERE countrylanguage.Percentage > (
    SELECT max(Percentage)
    FROM countrylanguage
    WHERE countrylanguage.CountryCode = c.Code
    AND countrylanguage.IsOfficial = "T"
);

-- 5
/*
Listar (sin duplicados) aquellas regiones que tengan 
países con una superficie menor a 1000 km2 y exista 
(en el país) al menos una ciudad con más de 100000 habitantes.
(Hint: Esto puede resolverse con o sin una subquery, 
intenten encontrar ambas respuestas).
*/
SELECT country.Region, country.Name, country.Population, country.SurfaceArea
FROM country
JOIN city
ON city.CountryCode = country.Code
WHERE country.SurfaceArea < 1000
AND city.Population > 100000;

-- 6
/*
Listar el nombre de cada país con la cantidad de 
habitantes de su ciudad más poblada. 
(Hint: Hay dos maneras de llegar al mismo resultado.
 Usando consultas escalares o usando agrupaciones, encontrar ambas).
*/
SELECT c.Name, city.Name, city.Population
FROM country AS c
JOIN city
ON city.CountryCode = c.Code
WHERE city.Population = (
    SELECT max(Population)
    FROM city
    WHERE city.CountryCode = c.Code
);

-- 7 (No termino de entender que pide exactamente).

-- 8
/*
Listar la cantidad de habitantes por 
continente ordenado en forma descendente.
*/
SELECT con.Name, SUM(country.Population) AS TotalPopulation
FROM continent AS con
JOIN country ON country.Continent = con.Name
GROUP BY con.Name
ORDER BY TotalPopulation DESC;

-- 9
/*
Listar el promedio de esperanza de vida (LifeExpectancy)
por continente con una esperanza de vida entre 40 y 70 años.
*/
SELECT con.Name, AVG(country.LifeExpectancy) AS AvgLife
FROM continent AS con
JOIN country ON country.Continent = con.Name
GROUP BY con.Name
HAVING AvgLife > 40 AND AvgLife < 70
ORDER BY AvgLife DESC;

-- 10
/*
Listar la cantidad máxima, mínima, promedio y suma de 
habitantes por continente.
*/
SELECT con.Name AS Continente, MAX(country.Population) AS Maxima, MIN(country.Population) AS Minima,
        AVG(country.Population) AS Promedio, SUM(country.Population) AS Suma
FROM continent AS con
JOIN country ON country.Continent = con.Name
GROUP BY con.Name
ORDER BY con.Name ASC;