--Lista el nombre de la ciudad, nombre del país, región y forma de gobierno de las 10 ciudades más pobladas del mundo.
SELECT A.Name as Country, A.Region, A.GovernmentForm, B.Name as City, B.Population as PopulationByCity
FROM country AS A
INNER JOIN city as B ON A.Code = B.CountryCode
ORDER BY B.Population DESC
LIMIT 10;

--Listar los 10 países con menor población del mundo, junto a sus ciudades capitales (Hint: puede que uno de estos países no tenga ciudad capital asignada, en este caso deberá mostrar "NULL").

SELECT A.Name, A.Population as PopulationByCountry, B.Name as City 
FROM country as A 
LEFT JOIN city as B ON A.Capital = B.ID
ORDER BY A.Population DESC
LIMIT 10;
-- uso left join porque quiero TODOS los paises en A (los que no tengan capital seran NULL) 

--Listar el nombre, continente y todos los lenguajes oficiales de cada país. (Hint: habrá más de una fila por país si tiene varios idiomas oficiales).
SELECT A.Name, A.Continent, B.Language, B.CountryCode
FROM country AS A 
INNER JOIN countrylanguage as B ON A.Code = B.CountryCode
WHERE B.IsOfficial = 'T';

--Listar el nombre del país y nombre de capital, de los 20 países con mayor superficie del mundo.
SELECT A.Name as Country, B.Name as CapitalCity, A.SurfaceArea
FROM country as A
LEFT JOIN city as B ON A.Capital = B.ID 
ORDER BY SurfaceArea DESC
LIMIT 20;

--Listar las ciudades junto a sus idiomas oficiales (ordenado por la población de la ciudad) y el porcentaje de hablantes del idioma.
SELECT A.Name, B.Language, A.Population, B.Percentage
FROM city as A 
INNER JOIN countrylanguage as B ON A.CountryCode = B.CountryCode
WHERE B.IsOfficial = 'T'
ORDER BY A.Population DESC 

--Listar los 10 países con mayor población y los 10 países con menor población (que tengan al menos 100 habitantes) en la misma consulta.
(
    SELECT Name as Country, Population, 'Bottom10' AS Category
    FROM country 
    WHERE Population >= 100 
    ORDER BY Population ASC
    LIMIT 10
)
UNION 
(
    SELECT Name as Country, Population, 'Top10' AS Category
    FROM country 
    ORDER BY Population DESC
    LIMIT 10
);

--Listar aquellos países cuyos lenguajes oficiales son el Inglés y el Francés (hint: no debería haber filas duplicadas).
(
    SELECT A.Name as Country, B.Language 
    FROM country AS A 
    INNER JOIN countrylanguage as B ON A.Code = B.CountryCode
    WHERE B.IsOfficial = 'T' AND B.Language = 'ENGLISH'
)
UNION
(
    SELECT A.Name as Country, B.Language 
    FROM country AS A 
    INNER JOIN countrylanguage as B ON A.Code = B.CountryCode
    WHERE B.IsOfficial = 'T' AND B.Language = 'FRENCH'
);
-- canada aparece dos veces y no se si eso rompe lo de "no deberian haber filas duplicadas" ?? creo q no

--Listar aquellos países que tengan hablantes del Inglés pero no del Español en su población.
(
    SELECT A.Name as Country
    FROM country AS A 
    INNER JOIN countrylanguage as B ON A.Code = B.CountryCode
    WHERE B.LANGUAGE = 'English'
)
EXCEPT
(
    SELECT A.Name as Country
    FROM country AS A 
    INNER JOIN countrylanguage as B ON A.Code = B.CountryCode
    WHERE B.LANGUAGE = 'Spanish'
);



-- Parte II - Preguntas 
-- Sí, con `INNER JOIN` ambas consultas devuelven los mismos valores, ya que en los dos casos solo se seleccionan las ciudades cuyo país es Argentina; la diferencia es que en la primera consulta la condición `country.Name = 'Argentina'` está dentro del `ON`, mientras que en la segunda se aplica posteriormente mediante `WHERE`. En cambio, si se utiliza `LEFT JOIN`, las consultas no necesariamente devuelven los mismos resultados: en la primera se conservan todas las ciudades y, para aquellas cuyo país no sea Argentina, las columnas de `country` quedan en `NULL`, mientras que en la segunda el `WHERE country.Name = 'Argentina'` elimina esas filas, por lo que solo quedan las ciudades de Argentina.
