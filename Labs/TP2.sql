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

INSERT INTO `continent` VALUES ('Africa', 30370000, 20.4, `Cairo` , 608)
INSERT INTO `continent` VALUES (`Antarctica`, 14000000, 9.2, `) -- no existe como ciudad
-- 6 

--    FOREIGN KEY (Continent) REFERENCES Continent (Name)
