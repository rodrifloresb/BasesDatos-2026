-- PARTE 1 DDL
-- 1 
create database world;

-- 2
create table country (
    Code VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255),
    Continent VARCHAR(255),
    Region VARCHAR(255),
    SurfaceArea INT,
    IndepYear INT,
    Population INT,
    LifeExpectancy INT,
    GNP INT,
    GNPOld INT,
    LocalName VARCHAR(255),
    GovernmentForm VARCHAR(255),
    HeadOfState VARCHAR(255),
    Capital INT,
    Code2 VARCHAR(255)
 );

create table city (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    CountryCode VARCHAR(255),
    District VARCHAR(255),
    Population INT,

    FOREIGN KEY (CountryCode) REFERENCES country(Code)
);

create table countrylanguage (
    CountryCode VARCHAR(255),
    Language VARCHAR(255),
    IsOfficial VARCHAR(255),
    Percentage INT,

    PRIMARY KEY (CountryCode, Language),
    FOREIGN KEY (CountryCode) REFERENCES country(Code)
);

-- 3
-- Datos de world-data.sql insertados

-- 4
-- Crear una tabla "Continent" que tenga los siguientes atributos:
-- Nombre del continente. (Clave Primaria)
-- Área (en km2).
-- Porcentaje de masa terrestre.
-- Ciudad más poblada (Opcional: referencia uno-a-uno a la tabla "city").

create table continent (
    Name VARCHAR(255) PRIMARY KEY,
    Area INT,
    MasaTerrestre FLOAT,
    MostPopulation VARCHAR(255),
    MostPopulationRef INT,

    FOREIGN KEY (MostPopulationRef) REFERENCES city (ID)
);


-- 5 

INSERT INTO `continent` VALUES ('Africa', 30370000, 20.4, 'Cairo' , 608);

INSERT INTO `city` VALUES (4080, 'McMurdo Station', 'ATA', 'Ross Dependency', 1000);
INSERT INTO `continent` VALUES ('Antarctica', 14000000, 9.2, 'McMurdo Station', 4080);

INSERT INTO `city` VALUES (4081, 'Mumbai', 'IND', 'Maharashtra', 12442373);
INSERT INTO `continent` VALUES ('Asia', 44579000, 29.5, 'Mumbai', 4081);

INSERT INTO `city` VALUES (4082, 'Instanbul', 'TUR', 'Istanbul', 15848000);
INSERT INTO `continent` VALUES ('Europe', 10180000, 6.8, 'Instanbul', 4082);

INSERT INTO `continent` VALUES ('North America', 24709000, 16.5, 'Mexico', 864);

INSERT INTO `continent` VALUES ('Oceania', 8600000, 5.9, 'Sydney', 130);

INSERT INTO `continent` VALUES ('South America', 17840000, 12.0, 'So Paulo', 206);

-- 6 
-- DESC table; Te permite ver el esquema.

ALTER TABLE country ADD FOREIGN KEY (Continent) REFERENCES continent (Name);

-- PARTE 2 DML

-- 1. 
SELECT Name, Region FROM country ORDER BY Name ASC;

-- 2.
SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 10;

-- 3.
SELECT Name, Region, SurfaceArea, GovernmentForm FROM country ORDER BY SurfaceArea ASC LIMIT 10;

-- 4.
SELECT Name FROM country WHERE IndepYear IS NULL;

-- 5.
    SELECT c.Name, cl.Language, cl.Percentage
    FROM country c
    JOIN countrylanguage cl ON c.Code = CountryCode
    WHERE cl.IsOfficial = 'T';

-- 6.
UPDATE countrylanguage SET Percentage = 100.0 WHERE CountryCode = 'AIA';

-- 7.
SELECT * FROM city WHERE District = 'Crdoba';

-- 8.
DELETE FROM city WHERE District = 'Crdoba' AND CountryCode != 'ARG';

-- 9.
SELECT Name, HeadOfState FROM country WHERE HeadOfState LIKE  '%John%';

-- 10.
    SELECT Name, Population 
    FROM country 
    WHERE Population > 35000000 AND Population < 45000000 
    ORDER BY Population DESC;
