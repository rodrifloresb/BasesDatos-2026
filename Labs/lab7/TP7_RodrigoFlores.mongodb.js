// Parte I

// Ej 1
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

db.movies.find({
    $and:[{"year": {$gte:1990, $lte:1999}, "imdb.rating": {$type: "double"}}]},
    {"title":1, "year":1, "cast":1, "directors":1, "imdb.rating":1}
).sort(
    {"imdb.rating": -1}
).limit(
    10
)


// Ej 3


// {
//   _id: ObjectId('5a9427648b0beebeb69579cc'),
//   name: 'Andrea Le',
//   email: 'andrea_le@fakegmail.com',
//   movie_id: ObjectId('573a1390f29313caabcd418c'),
//   text: 'Rem officiis eaque repellendus amet eos doloribus. Porro dolor voluptatum voluptates neque culpa molestias. Voluptate unde nulla temporibus ullam.',
//   date: ISODate('2012-03-26T23:20:16.000Z')
// }


db.comments.find(
    {$and:[{"movie_id": {$eq: ObjectId("573a1399f29313caabcee886")},
    "date": {$gte: ISODate('2014-01-01T00:00:00.000Z'), $lte: ISODate('2016-01-01T00:00:00.000Z')}
    }]},
    {"name":1, "email":1, "text":1, "date":1 }
).sort({date: 1})

db.comments.countDocuments(
    {$and:[{"movie_id": {$eq: ObjectId("573a1399f29313caabcee886")},
    "date": {$gte: ISODate('2014-01-01T00:00:00.000Z'), $lte: ISODate('2016-12-31T00:00:00.000Z')}
    }]}
)