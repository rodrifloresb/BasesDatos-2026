// Ej 1
/*  
Cantidad de cines (theaters) por estado.
*/

db.theaters.aggregate(
    [
        {
            $group: {
              _id: "$location.address.state",
              contador: {
                $sum: 1
              }
            }
        },
        {
            $sort: {
                contador: 1
            }
        }
    ]
)

// Ej 2
/*
Variante
Cantidad de estados con al menos 10 cines (theaters) registrados
*/

db.theaters.aggregate(
    [
        {
            $group: {
              _id: "$location.address.state",
              contador: {
                $sum: 1
              }
            }
        },
        {
            $match: {
              contador: {$gte: 10}
            }
        },
        {
            $sort: {
                contador: 1
            }
        }
    ]
)

// Ej 3
/*
Cantidad de películas dirigidas por "Louis Lumière". 
Se puede responder sin pipeline de agregación, realizar ambas queries. 
*/

db.movies.aggregate(
    [
        {
            $match: {
              directors: {$in: ["Louis Lumière"]}
            }
        },
        {
            $count: "Dirigidas_por_louis"
        }
    ]
)

db.movies.countDocuments(
    {
        directors: {$in: ["Louis Lumière"]}
    }
)

// Ej 4
/*
Cantidad de películas estrenadas en los años 50 (desde 1950 hasta 1959).
Se puede responder sin pipeline de agregación, realizar ambas queries.
*/

db.movies.aggregate(
    [
        {
            $match:{
                year: {$gte: 1950, $lte: 1959}
            }
        },
        {
            $count: "Peliculas_de_los_50"
        }
    ]
)

// Ej 5
/* 
Listar los 10 géneros con mayor cantidad de películas
(tener en cuenta que las películas pueden tener más de un género). 
Devolver el género y la cantidad de películas. 
Hint: unwind puede ser de utilidad
*/

db.movies.aggregate(
    [
        {
            $unwind: "$genres"
        },
        {
            $group: {
              _id: "$genres",
              contador: {
                $sum: 1
              }
            }
        },
        {
            $sort: {
                contador: -1
            }
        },
        {
            $limit: 10
        }
    ]
)

// Ej 6
/*  
Top 10 de usuarios con mayor cantidad de comentarios, mostrando Nombre, 
Email y Cantidad de Comentarios.
*/

db.comments.aggregate(
    [
        {
            $group: {
              _id: {name: "$name", email: "$email"},
              cantidadComentarios: {
                $sum: 1
              }
            }
        },
        {
            $project: {
              _id: 1,
              cantidadComentarios: 1
            }
        },
        {
            $sort: {
                cantidadComentarios: -1
            }
        },
        {
            $limit: 10
        }
    ]
)

// Ej 7
/*  
Ratings de IMDB promedio, mínimo y máximo por año de las películas 
estrenadas en los años 80 (desde 1980 hasta 1989), 
ordenados de mayor a menor por promedio del año.
*/

db.movies.aggregate(
    [
        {
            $match: {
              year: {$gte: 1980, $lte: 1989},
              "imdb.rating": {$type: "double"}
            }
        },
        {
            $group: {
              _id: "$year",
              promedio: {
                $avg: "$imdb.rating"
              },
              minimo: {
                $min: "$imdb.rating"
              },
              maximo: {
                $max: "$imdb.rating"
              }
            }
        },
        {
            $sort: {
              promedio: -1
            }
        }
    ]
)

// Ej 8
/*
Título, año y cantidad de comentarios de las 10 películas 
con más comentarios.
*/

db.movies.aggregate(
    [
        {
            $lookup: {
              from: "comments",
              localField: "_id",
              foreignField: "movie_id",
              as: "comment"
            }
        },
        {
            $project: {
              title: 1,
              year: 1,
              cantidadComentarios: {$size: "$comment"}
            }
        },
        {
            $sort: {
              cantidadComentarios: -1
            }
        },
        {
            $limit: 10
        }
    ]
)

// Ej 9
/*
Crear una vista con los 5 géneros con mayor cantidad de comentarios, 
junto con la cantidad de comentarios.
*/

db.createView(
    "generoMasComentarios",
    "movies",
    [
        {
          $unwind: "$genres"
        },
        {
            $lookup: {
              from: "comments",
              localField: "_id",
              foreignField: "movie_id",
              as: "comment"
            }
        },
        {
            $group: {
              _id: "$genres",
              cantidadComentarios: {
                $sum: {$size: "$comment"}
              }  
            }
        },
        {
            $sort: {
              cantidadComentarios: -1
            }
        },
        {
            $limit: 5
        }
    ]
)


// Ej 10
/*
Listar los actores (cast) que trabajaron en 2 o más 
películas dirigidas por "Jules Bass". Devolver el nombre
de estos actores junto con la lista de películas 
(solo título y año) dirigidas por “Jules Bass” en las 
que trabajaron. 
*/

db.movies.aggregate(
    [
        {
            $match: {
              directors: {$in: ["Jules Bass"]}
            }
        },
        {
            $unwind: "$cast"
        },
        {
            $group: {
              _id: "$cast",
              count: {
                $sum: 1
              },
              titulosAños: {
                $addToSet: {
                    List:{
                        titulo: "$title",
                        año: "$year"
                    }
                }
              }
            }
        },
        {
            $match: {
              count: {$gte : 2}
            }
        }
    ]
)

// Ej 11
/*
Listar los usuarios que realizaron comentarios durante el 
mismo mes de lanzamiento de la película comentada, 
mostrando Nombre, Email, fecha del comentario, título de la
película, fecha de lanzamiento. 
HINT: usar $lookup con multiple condiciones 
*/

db.comments.aggregate([
  {
    $lookup: {
      from: "movies",
      let: { 
        comentario_movie_id: "$movie_id", 
        comentario_fecha: "$date" 
      },
      pipeline: [
        {
          $match: {
            $expr: {
              $and: [
                { $eq: ["$_id", "$$comentario_movie_id"] },
                { $eq: [{ $year: "$released" }, { $year: "$$comentario_fecha" }] },
                { $eq: [{ $month: "$released" }, { $month: "$$comentario_fecha" }] }
              ]
            }
          }
        }
      ],
      as: "pelicula"
    }
  },
  {
    $unwind: "$pelicula"
  },
  {
    $project: {
      _id: 0,
      nombre: "$name",
      email: "$email",
      fechaComentario: "$date",
      tituloPelicula: "$pelicula.title",
      fechaLanzamiento: "$pelicula.released"
    }
  }
])


{/* EJERCICIO 12:
    Listar el id y nombre de los restaurantes junto con su puntuación máxima,
    mínima y la suma total. Se puede asumir que el restaurant_id es único.
        
Resolver con $group y accumulators.
Resolver con expresiones sobre arreglos (por ejemplo, $sum) pero sin $group.
Resolver como en el punto b) pero usar $reduce para calcular la puntuación total.
Resolver con find.
*/}
// 1.
db.restaurants.aggregate([
  {
    $unwind: "$grades"
  },
  {
    $group: {
      _id: "$restaurant_id",
      name: { $first: "$name" },
      maxScore: { $max: "$grades.score" },
      minScore: { $min: "$grades.score" },
      totalScore: { $sum: "$grades.score" }
    }
  },
  {
    $project: {
      _id: 0,
      restaurant_id: "$_id",
      name: 1,
      maxScore: 1,
      minScore: 1,
      totalScore: 1
    }
  }
])

// 2.
db.restaurants.aggregate([
  {
    $project: {
      _id: 0,
      restaurant_id: 1,
      name: 1,
      maxScore: { $max: "$grades.score" },
      minScore: { $min: "$grades.score" },
      totalScore: { $sum: "$grades.score" }
    }
  }
])

// 3.
db.restaurants.aggregate([
  {
    $project: {
      _id: 0,
      restaurant_id: 1,
      name: 1,
      maxScore: { $max: "$grades.score" },
      minScore: { $min: "$grades.score" },
      totalScore: {
        $reduce: {
          input: "$grades",
          initialValue: 0,
          in: { $add: ["$$value", "$$this.score"] }
        }
      }
    }
  }
])

// 4.
db.restaurants.find(
  {},
  {
    _id: 0,
    restaurant_id: 1,
    name: 1,
    maxScore: { $max: "$grades.score" },
    minScore: { $min: "$grades.score" },
    totalScore: { $sum: "$grades.score" }
  }
)
{/* EJERCICIO 13:
    Actualizar los datos de los restaurantes añadiendo dos campos nuevos. 
    "average_score":
        con la puntuación promedio
    "grade": 
        con "A" si "average_score" está entre 0 y 13, 
        con "B" si "average_score" está entre 14 y 27 
        con "C" si "average_score" es mayor o igual a 28
    Se debe actualizar con una sola query.
    HINT1. Se puede usar pipeline de agregación con la operación update
    HINT2. El operador $switch o $cond pueden ser de ayuda.
*/}
db.restaurants.updateMany(
  {},
  [
    {
      $set: {
        average_score: { $avg: "$grades.score" }
      }
    },
    {
      $set: {
        grade: {
          $cond: {
            if: { $lte: ["$average_score", 13] },
            then: "A",
            else: {
              $cond: {
                if: { $lte: ["$average_score", 27] },
                then: "B",
                else: "C"
              }
            }
          }
        }
      }
    }
  ]
)

