
# MongoDB

```bash
➜  ~ docker exec -it mongo-labs mongosh
```

comandos basicos:
- show dbs;  o  show databases;
- use [db]    db -> variable que representa la base actual.
- show collections; o show tables;
- db.createCollection(name, [options])

### Crear una nuevas instancia.
```json
db.collection.insertOne(
	{document},
	{options}
)

db.collection.insertMany(
	[{document1}, .. , {documentN}],
	{options}
)
```

### Obtener datos
```json
db.collection.find(
	{filtros},
	{campos a mostrar}
)
```

Operadores que permiten comparar en el filter:
- $eq  : igual
- $nq  : no igual
- $gt  : mayor
- $gte : mayor o igual
- $lt  : menor
- $lte : menor o igual
- $in  : se encuentra
- $nin : no se encuentra

Tambien se pueden usar operadores como:
- $and
- $or
- $nor
- $not

```json
db.collection.find(
	{ $operador : [{filtro1} , .. , {filtroN}]}
)
```


