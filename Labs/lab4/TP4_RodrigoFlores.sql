-- Parte I
-- 1 

SELECT city.Name, country.Name
FROM city
JOIN country
ON city.CountryCode = country.Code
AND country.Population < 10000
ORDER BY country.Name ASC;

-- 2
SELECT city.Name, country.Name
FROM city
JOIN country
ON city.CountryCode = country.Code
WHERE country.Population > (
    SELECT avg(Population) FROM country
)
ORDER BY country.Name ASC;

-- 3 
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
SELECT country.Region, country.Name, country.Population, country.SurfaceArea
FROM country
JOIN city
ON city.CountryCode = country.Code
WHERE country.SurfaceArea < 1000
AND city.Population > 100000;

-- 6
SELECT c.Name, city.Name, city.Population
FROM country AS c
JOIN city
ON city.CountryCode = c.Code
WHERE city.Population = (
    SELECT max(Population)
    FROM city
    WHERE city.CountryCode = c.Code
);