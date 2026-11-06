// Parte I

// ----------------- Ej1 ----------------- 
db.runCommand({
    collMod: "users",
    validator: {
    $jsonSchema: {
        bsonType: "object",
        required: ["name","email","password"],
        properties: {
        name: {
            bsonType: "string",
            maxLength: 30,
            description: "El name debe ser un string de hasta 30 caracteres"
        },
        email1: {
            bsonType: "string",
            pattern:"^(.*)@(.*)\\.(.{2,4})$",
            description: "El email debe ser un string que matchee con la expresión regular: ^(.*)@(.*)\\.(.{2,4})$"
        },
        password: {
            bsonType: "string",
            maxLength: 50,
            description: "El password debe ser un string de hasta 50 caracteres"
        },
        },
    }
    },
    validationLevel: "strict",
    validationAction: "error"
});

// ----------------- Ej2 ----------------- 
db.getCollectionInfos( { name: "users" } )

// ----------------- Ej3 ----------------- 
db.runCommand({
    collMod: "theaters",
    validator: {
    $jsonSchema: {
        bsonType: "object",
        required: ["theaterId","location"],
        properties: {
        theaterId: {
            bsonType: "int",
            description: "El theaterId debe ser un integer"
        },
        location: {
            bsonType: "object",
            required: [ "address" ],
            properties: {
                "address": { 
                    bsonType: "object",
                    required: [ "street1", "city", "state", "zipcode" ],
                    properties: {
                        street1:{bsonType: "string"}, 
                        city:{bsonType: "string"}, 
                        state:{bsonType: "string"}, 
                        zipcode:{bsonType: "string"}, 
                    }
                },
                "geo": { 
                    bsonType: "object",
                    properties: {
                        type:{
                            bsonType: "string",
                            enum: ["Point", null]
                        }, 
                        coordinates: {
                            bsonType: "array",
                            minItems: 2,
                            maxItems: 2,
                            items: {
                                    bsonType: "double"
                                }
                            },
                    }
                }
            }
        },
        },
    }
    },
    validationLevel: "moderate",
    validationAction: "error"
});

// ----------------- Ej4 ----------------- 
db.runCommand({
    collMod: "movies",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["title","year"],
            properties: {
                title: {
                    bsonType: "string",
                    description: "El title debe ser un string"
                },
                year: {
                    bsonType: "int",
                    minimum: 1900,
                    maximum: 3000,
                    description: "El year debe ser un integer"
                },
                cast: {
                    bsonType: "array",
                    uniqueItems: true,
                    items: {
                        bsonType: "string"
                    }
                },
                directors: {
                    bsonType: "array",
                    uniqueItems: true,
                    items: {
                        bsonType: "string"
                    }
                },
                countries: {
                    bsonType: "array",
                    uniqueItems: true,
                    items: {
                        bsonType: "string"
                    }
                },
                genres: {
                    bsonType: "array",
                    uniqueItems: true,
                    items: {
                        bsonType: "string"
                    }
                },
            }
        },
    },  
    validationLevel: "moderate",
    validationAction: "error"
});

// ----------------- Ej5 ----------------- 
db.createCollection( 
    "userProfiles", 
    {   validator: {
            $jsonSchema: {
                bsonType: "object",
                required: ["user_id","language"],
                properties: {
                    user_id: {
                        bsonType: "objectId",
                        description: "El user_id debe ser un objectId"
                    },
                    language: {
                        bsonType: "array",
                        enum: [ "English", "Spanish", "Portuguese" ],
                    },
                    favorite_genres: {
                        bsonType: "array",
                        uniqueItems: true,
                        items: {
                            bsonType: "string"
                        }
                    }
                }
            }
        }, 
        validationLevel: "strict", 
        validationAction: "error" ,
    }
)

// Parte II

// ----------------- Ej6 ----------------- 
// Relación entre movies y comment
// La relación es del tipo : One-To-Many; siendo que se usó una referencia en la colección comments 
// hacia movies, haciendo que varios comments se vinculen a una pelicula. 
// Se sabe que esto es así porque en la colección comments, el campo movie_id actúa como una clave de 
// referencia al campo _id de la colección movies, permitiendo vincular cada comentario con su película.

// ----------------- Ej7 ----------------- 
// Se planea hacer:
// 1
// Entidades: books,categories
// Relación: One-To-Many
// Estrategia: Documentos Anidados
// 2
// Entidades: orders, order_detail
// Relación: One-To-One
// Estrategia: Documentos Referenciados
// 3
// Entidades: order_detail, books
// Relación: Many-To-One
// Estrategia: Documentos Referenciados