// Parte I

// Ej 1
/*
Insertar 5 nuevos usuarios en la colección users. Para cada nuevo usuario creado,
insertar al menos un comentario realizado por el usuario en la colección comments.
*/
db.users.insertMany([
    {"name": "Homero simpson", "email":"homer@fakemail.com", "password":"1234"},
    {"name": "Margarot", "email":"marge@fakemail.com", "password":"1234"},
    {"name": "Bart Simpson", "email":"el_barto@fakemail.com", "password":"1234"},
    {"name": "Lisa simpson", "email":"lisa1@fakemail.com", "password":"1234"},
    {"name": "Abuelo simpson", "email":"homerGrandPa@fakemail.com", "password":"1234"}
]);


db.comments.insertMany([
    {"name": "Homero simpson", "email":"homer@fakemail.com", "movie_id":"573a1390f29313caabcd4132", "text":"Ticket aprobado", "date": new Date()},
    {"name": "Margarot", "email":"marge@fakemail.com", "movie_id":"573a1390f29313caabcd4132", "text":"Ticket aprobado", "date": new Date()},
    {"name": "Bart Simpson", "email":"el_barto@fakemail.com", "movie_id":"573a1390f29313caabcd4132", "text":"Ticket aprobado", "date": new Date()},
    {"name": "Lisa simpson", "email":"lisa1@fakemail.com", "movie_id":"573a1390f29313caabcd4132", "text":"Ticket aprobado", "date": new Date()},
    {"name": "Abuelo simpson", "email":"homerGrandPa@fakemail.com", "movie_id":"573a1390f29313caabcd4132", "text":"Ticket aprobado", "date": new Date()}
]);

// Ej 2
/*
Listar el título, año, actores (cast), directores y rating de las 10 películas con mayor rating
(“imdb.rating”) de la década del 90. ¿Cuál es el valor del rating de la película que tiene
mayor rating? (Hint: Chequear que el valor de “imdb.rating” sea de tipo “double”).
*/
db.movies.find({
    $and:[{"year": {$gte:1990, $lte:1999}, "imdb.rating": {$type: "double"}}]},
    {"title":1, "year":1, "cast":1, "directors":1, "imdb.rating":1}
).sort(
    {"imdb.rating": -1}
).limit(
    10
)


// Ej 3
/*
Listar el nombre, email, texto y fecha de los comentarios que la película con id (movie_id)
ObjectId("573a1399f29313caabcee886") recibió entre los años 2014 y 2016 inclusive.
Listar ordenados por fecha. Escribir una nueva consulta (modificando la anterior) para
responder ¿Cuántos comentarios recibió?
*/
db.comments.find(
    {$and:[{"movie_id": {$eq: ObjectId("573a1399f29313caabcee886")},
    "date": {$gte: ISODate('2014-01-01T00:00:00.000Z'), $lte: ISODate('2016-12-31T24:00:00.000Z')}
    }]},
    {"name":1, "email":1, "text":1, "date":1 }
).sort({date: 1})

db.comments.countDocuments(
    {$and:[{"movie_id": {$eq: ObjectId("573a1399f29313caabcee886")},
    "date": {$gte: ISODate('2014-01-01T00:00:00.000Z'), $lte: ISODate('2016-12-31T00:00:00.000Z')}
    }]}
)

// Ej 4
/*
Listar el nombre, id de la película, texto y fecha de los 3 comentarios más recientes
realizados por el usuario con email patricia_good@fakegmail.com.
*/
db.comments.aggregate([
    {
        $lookup: {
          from: "movies",
          localField: "movie_id",
          foreignField: "_id",
          as: "movie"
        }
    },
    {
        $match: {
          "email": {$eq: "patricia_good@fakegmail.com" }
        }
    },
    {
        $sort: {
          date: -1
        }
    },
    {
        $limit: 3
    },
    {
        $project: {
          "_id":0,
          "movie.title": 1,
          "movie._id": 1,
          "text": 1,
          "date": 1
        }
    }
])

// Ej 5
/*
Listar el título, --idiomas (languages)--, géneros, fecha de lanzamiento (released) y número
de votos (“imdb.votes”) de las películas de géneros Drama y Action (la película puede
tener otros géneros adicionales), que solo están disponibles en un único idioma y por
último tengan un rating (“imdb.rating”) mayor a 9 o bien tengan una duración (runtime) de
al menos 180 minutos. Listar ordenados por fecha de lanzamiento y número de votos.
*/

db.movies.find(
    {
        genres: {$in: ["Drama", "Action"]},
        "imdb.rating": {$gt: 9},
        runtime: {$gte: 180}
    },
    {
        _id: 0,
        title: 1,
        genres: 1,
        released: 1,
        "imdb.votes": 1
    }
)

// Ej 6
/* 
Listar el id del teatro (theaterId), estado (“location.address.state”), ciudad
(“location.address.city”), y coordenadas (“location.geo.coordinates”) de los teatros que se
encuentran en algunos de los estados "CA", "NY", "TX" y el nombre de la ciudades
comienza con una ‘F’. Listar ordenados por estado y ciudad.
*/

db.theaters.find(
    {
        "location.address.state": {$in: ["CA", "NY", "TX"]},
        "location.address.city": {$regex: /^F/}
    },
    {
        theatersId: 1,
        "location.address.state": 1,
        "location.address.city": 1,
        "location.geo.coordinates": 1
    }
).sort(
    {
        "location.address.state": 1,
        "location.address.city": 1
    }
)

// Ej 7
/*
Actualizar los valores de los campos texto (text) y fecha (date) del comentario cuyo id es
ObjectId("5b72236520a3277c015b3b73") a "mi mejor comentario" y fecha actual
respectivamente.
*/

db.comments.updateOne(
    {
        
    }
)