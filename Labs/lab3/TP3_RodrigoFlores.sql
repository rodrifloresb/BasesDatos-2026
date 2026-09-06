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