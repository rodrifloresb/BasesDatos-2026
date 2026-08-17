mysql>

    SHOW DATABASES; // Ver bd existentes
    CREATE DATABASE name; // Crear una bd
    USE name; // Usar bd
    DROP DATABASE name; // eliminar bd
    exit; // Salir de mysql


    --- TABLAS ---

    // Crear tabla 
    CREATE TABLE user (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(50),
        email VARCHAR(100) UNIQUE
    );

    INT: Para numeros enteros
    VARCHAR(n): Text de longiutd n
    PRIMARY KEY: Clave principal, unico identificador para cada fila
    AUTO_INCREMENT: Aumenta automaticamente el valor de la columna
    UNIQUEL Asegura que cada valor en esa columna sea unico


    //  Mostrar tablas
    SHOW TABLES;

    // Describir una tabla
    DESCRIBE user;

    // Eliminar tabla
    DROP TABLE user;

    --- CRUD // manipular datos ---   

    // Insertar datos
    INSERT INTO user (name, email) VALUES ('name', 'email@gmal.com');

    // Consultas
    SELECT * FROM user; // Selecciona todas las columnas
    SELECT name, email FROM user WHERE id = 1; // Selecciona columnas especificas

    // Actualizar datos
    UPDATE user SET email = 'email2@gmail.com' WHERE id = 1;

    // Eliminar datos
    DELETE FROM user WHERE id = 1;
