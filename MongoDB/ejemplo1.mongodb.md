# Ejemplo 1

[Referencia consultas](https://docs.mongodb.com/manual/reference/operator/query/where/)

## Insertar datos iniciales
Para poblar con datos una base de datos, existen numerosas formas:

* Script de shell: la shell de mongo admite scripts Javascript, por lo que podríamos instanciar una variable dentro de un bucle y poblar una colección con datos de prueba.

for (i = 0; i & lt; 10; ++i) {
    var doc = {
        name: "user-" + i;
    }
 
    db.posts.insert(doc);
}
* Ejecutar el script creado en una herramienta externa:

> load(“scripts/myusers.js”)

* Importar un documento que solo contenga Jsons: utilizando la herramienta mongoimport

Mongoimport –d testdb –c users myusers.json

* Desde la aplicación
\[Próximo módulo]

## Instrucciones 

### Insercion
> db.scores.insert({ _id: 1, username : “findemor”, score : 50, finished : true })
> db.scores.insert({ _id: 2, username : “eden4ever”, score : 80, finished : false })
> db.scores.insert({ _id: 3, username : “franbuipa”, score : 30 })

### Crear colecciones
Se pueden definir colecciones sin insertar registros... en este caso solo se registran 1000 registros, y luego se borran los ás antiguos para mantener los mil.
> db.createCollection(“log”, { capped: true, max: 1000 })

Devuelve todos
> db.scores.find()
Devuelve uno (al azar)
> db.scores.findOne()
 Busquedas con filtros
> db.scores.find({ username : “findemor” })

> db.scores.find({ score : { $gt : 20, $lte: 50 }})

> db.scores.find({ finished : { $exists : false } })

Listar elementos usando expresiones regulares: cuyo username contenga la cadena uip

> db.scores.find({ username : { $regex : “uip” }})

Encontrar elementos por tipo de dato de los atributos: en el ejemplo, obtenemos los documentos donde el atributo finished es booleano. El tipo del atributo se identifica según la especificación de BSON.

> db.scores.find({ finished : { $type : 8 }})

Hacer una agrupación OR de dos consultas, en este caso elementos con _id = 1 OR _id = 2

> db.scores.find({ $or : [ { _id : 1 }, { _id : 2 } ] })

Contar el número de documentos de la colección.

> db.scores.count()

También podemos aplicar filtros.

> db.scores.count({ finished : true })

### INdices

db.scores.insert({
    _id: 4,
    username: "cocinero",
    favorites: ["cocinar", "postres"],
    address: {
        country: "es",
            city: "madrid"
    }
})
 
 db.scores.insert({
    _id: 5,
        username: "deportista",
        favorites: ["running"],
        address: {
            country: "es",
                city: "toledo"
        }
})

Consultar por coincidencias en un array: listamos los documentos cuyo array de favoritos contenga el elemento postres… evidentemente será el usuario cocinero.

> db.scores.find({ favorites : “postres” }).pretty()

Obtener los documentos que contengan en el array todos los elementos especificados.

> db.scores.find({ favorites : { $all : [“postres”, “cocinar”] }}).pretty()

Listar los documentos que contengan en el array alguno de los elementos especificados.

> db.scores.find({ favorites : { $in : [“cocinar”] }}).pretty()

Listando los elementos por valor de alguno de los atributos del documento embebido. En este caso, documentos cuya ciudad es madrid.

> db.scores.find({ “address.city” : “madrid” }).pretty()

### Paginación
Obtener datos con paginación: en el ejemplo, podemos ver cómo obtener la segunda página de resultados, considerando que nuestras páginas fuesen de 2 elementos únicamente. Para ello, utilizamos la operación skip (que determina cuántos elementos se van a ignorar de los resultados obtenidos) y la operación limit (que especifica cuántos elementos deseamos obtener del nuevo conjunto de resultados).

El orden es irrelevante, ya que primero se aplicará el filtro (si existe), después skip, y finalmente limit.

> db.scores.find().skip(2).limit(2)

Ordenar resultados en MongoDB
Podemos añadir la operación sort para ordenar los resultados por el valor de sus atributos. Para utilizar el orden natural, hay que utilizar el 1 positivo, y para invertir los resultados, un 1 negativo. Por supuesto podemos combinarlo con skip o limit, y el orden sigue siendo relevante, primero se aplica el filtro, luego sort, después skip y finalmente limit.

> db.scores.find().sort({ _id : 1 }).limit(2)

> db.scores.find().sort({ _id : -1 }).limit(2)

### Manejo de cursores en MongoDB
Como ya hemos visto, la shell de mongo funciona como una consola javascript, por lo que podemos escribir pequeños programas, o iterar sobre cursores, simplemente declarándolo como una variable javascript.

> var c = db.scores.find().sort({ username : -1 }).limit(2)
> c.hasNext()

> c.next()

### Actualización de documentos en MongoDB
Para actualizar documentos, basta con utilizar la operación update con dos parámetros. El primero permite especificar el filtro que determina qué documentos serán actualizados (pero ojo, que solo se actualizará el primer elemento que coincida y se detendrá la operación, comportamiento que se puede modificar como veremos más abajo). El segundo parámetro es la actualización que se va a realizar.

Es importante tener en cuenta que la operación update actualizará el documento en su totalidad, para comprenderlo, prestad atención a lo que pasa con el atributo finished del siguiente documento cuando se actualiza su score.

> db.scores.find({ _id : 1 })

> db.scores.update({ _id : 1 }, { _id : 1, username : “findemor”, score : 60 })

> db.scores.find({ _id : 1 })

Podemos evitar este efecto, como se muestra a continuación.

Actualizar un atributo sin modificar el resto del elemento (si el atributo existe, se modifica, en otro caso se añade).

> db.scores.find({ _id : 1 })

> db.scores.update({ _id : 1 }, { $set : { finished : true }})

> db.scores.find({ _id : 1 })

Se pueden realizar otras acciones trabajando con atributos independientes.

Incrementar el valor (si no existe, lo crea con el valor especificado)

> db.scores.update({ _id : 1 }, { $inc : { score : 1 }})

> db.scores.find({ _id : 1 })

Eliminar una propiedad (o atributo) de un elemento.

> db.scores.update({ _id : 1 }, { $unset : { finished : 1 }})

> db.scores.find({ _id : 1 })

UPSERT en MongoDB, actualiza el documento, y si no existe, lo crea aprovechando los datos del update como definición del nuevo documento.

> db.scores.find({ _id : 10 }).count()

> db.scores.update({ _id : 10 }, { $set : { score : 74 } }, { upsert : true })

> db.scores.find({ _id : 10 })

### Actualización masiva de documentos
Cuando se realiza un update, se modificará el primer elemento coincidente y se detendrá la operación. Si queremos realizar una actualización masiva, hay que utilizar el parametro multi. Prestad atención el valor de nModified (numero de documentos modificados) en la respuesta de la operación, tras las siguientes operaciones.

> db.scores.update({}, { $set : { finished : true }})

> db.scores.update({}, { $set : { finished : true }}, { multi : true })

### Actualizando atributos de tipo Array (listas)
Los arrays admiten numerosas operaciones específicas que proporcionan una enorme flexibilidad de actualización en MongoDB, vamos a repasar rápidamente algunas de ellas.

Primero veamos qué arrays tenemos en nuestra colección, para que podáis seguir la ejecución de las operaciones.

> db.scores.find({ favorites : { $exists : 1 }}).pretty()

Modificar un elemento concreto (por posición) dentro de un array.

> db.scores.update({ _id:4 }, { $set : { “favorites.1” : “comer” }})

> db.scores.findOne({ _id:4 })

Añadir un elemento al array por la derecha

> db.scores.update({ _id:4 }, { $push : { favorites : “cazar” }})

Eliminar un elemento del array por la izquierda (para que fuese por la derecha, habria que sustituir -1 por 1 positivo)

> db.scores.update({ _id:4 }, { $pop : { favorites : -1 }})

> db.scores.findOne({ _id : 4 })

Añadir todos los elementos especificados al Array

> db.scores.update({ _id : 4 }, { $pushAll : { favorites : [ “a”, “b”, “c” ]}})

> db.scores.findOne({ _id : 4 })

Eliminar todos los elementos coincidentes del Array. También podríamos usar el operador pull para eliminar solo un elemento cualquiera especificando su valor.

> db.scores.update({ _id : 4 }, { $pullAll : { favorites : [ “a”, “b”, “c” ]}})

> db.scores.findOne({ _id : 4 })

Añadir un elemento al array únicamente si no existe ya.

> db.scores.update({ _id : 4 }, { $addToSet : { favorites : “cazar” }})

### Eliminar datos y colecciones en MongoDB
Para eliminar documentos, podemos determinar un criterio de filtro para eliminar todos los coincidentes del mismo modo que lo hacemos al utilizar el comando find.

> db.scores.remove({ _id : 4 })

Eliminar una colección (y todos los documentos que contiene)

> db.scores.drop()

> show collections



