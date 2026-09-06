DROP TABLE IF EXISTS `continent`;
CREATE TABLE `continent` (
    `Name` varchar(100) NOT NULL, 
    `Area` INT NOT NULL, 
    `Percent_total_mass` INT NOT NULL, 
    `Most_populous_city` varchar(100) NOT NULL,
    PRIMARY KEY (`Name`)
);

ALTER TABLE continent
MODIFY COLUMN Name ENUM('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL;

-- falta hacer lo de (Opcional: referencia uno-a-uno a la tabla "city") en la ciudad mas poblada 

INSERT INTO `city` VALUES (NULL, 'McMurdo Station', 'ATA', 'Ross Dependency', 1000);

INSERT INTO `continent` VALUES ('Africa', '30370000', '20.4', 'Cairo, Egypt'); 
INSERT INTO `continent` VALUES ('Antarctica', '14000000', '9.2', 'McMurdo Station');
INSERT INTO `continent` VALUES ('Asia', '44579000', '29.5', 'Mumbai, India');
INSERT INTO `continent` VALUES ('North America', '24709000', '16.5', 'Ciudad de México, Mexico');
INSERT INTO `continent` VALUES ('Oceania', '8600000', '5.9', 'Sydney, Australia');
INSERT INTO `continent` VALUES ('South America', '17840000', '12.0', 'São Paulo, Brazil');
INSERT INTO `continent` VALUES ('Europe', '10180000',
'6.8', 'Instanbul, Turquia');

-- Modificar la tabla "country" de manera que el campo "Continent" pase a ser una clave externa (o foreign key) a la tabla Continent.*
ALTER TABLE country
ADD CONSTRAINT fk_continent_name
FOREIGN KEY (Continent) REFERENCES continent (Name);

--Devuelva una lista de los nombres y las regiones a las que pertenece cada país ordenada alfabéticamente.
SELECT Name, Region
FROM country
ORDER BY Name ASC;

--Liste el nombre y la población de las 10 ciudades más pobladas del mundo.
SELECT Name, Population 
FROM city
ORDER BY Population DESC
LIMIT 10;

--Liste el nombre, región, superficie y forma de gobierno de los 10 países con menor superficie.
SELECT Name, Region, SurfaceArea, GovernmentForm
FROM country 
ORDER BY SurfaceArea ASC 
LIMIT 10; 

--Liste todos los países que no tienen independencia (hint: ver que define la independencia de un país en la BD).
SELECT Name
FROM country 
WHERE IndepYear is NULL;

--Liste el nombre y el porcentaje de hablantes que tienen todos los idiomas declarados oficiales.
SELECT CountryCode, Percentage
FROM countrylanguage 
WHERE IsOfficial = 'T';
