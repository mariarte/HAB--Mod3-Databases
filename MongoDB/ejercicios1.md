
## Ejercicios
1 Crear base de datos

	1 Cree una base de datos llamada usermanaged, borrar  y volver a crear. Compruebe en qué base de datos se está trabando.
use usermanaged  // crear
db.dropDatabase()  //borrar
show databases // ver todas las bases de datos
db.getName() // en que base de datos estamos trabajando



2 Crear una colección e insertar un registro

	1 Cree una colección llamada clientes en usermanaged creada en el Ejercicio 1 e inserte el documento a continuación. Compruebe si el documento está insertado correctamente.

```json
{ "firstName":"John", 
  "lastName":"West", 
  "email":"john.west@mail.com", 
  "phone":"032345432134",
  "BusinessType": ["Sell", "Sugar", "Drinks"],
  "Reference":100,
  "Company":"Coca-Cola"}
```
db.clientes.insert({ "firstName":"John", 
...   "lastName":"West", 
...   "email":"john.west@mail.com", 
...   "phone":"032345432134",
...   "BusinessType": ["Sell", "Sugar", "Drinks"],
...   "Reference":100,
...   "Company":"Coca-Cola"})
// sino existe la coleccion, en el momento que haces un insert te la crea

db.clientes.find() // devuelve todos los documentos insertados
db.clientes.findOne() // devuelve solo 1 documento insertado



3 Carga de archivos JSON

	1 Cree una colección llamada transactions en usermanaged (borrar si ya existe) y cargue de forma masiva los datos de un archivo json, transaction.json (vea los datos al final de las preguntas).	

mongoimport --db usermanaged --jsonArray --collection transactions --mode upsert --upsertFields Id --file  transaction.json // importa el json

db.transactions.find().pretty()



	2 Anexa los registros con el mismo archivo, transaction.json

	3 Insertar el registro del nuevo archivo llamado transaction_upsert.json (vea los datos al final de las preguntas).

4 Archivo CSV de carga masiva

	1 Crear una colección y cargar datos desde un archivo CSV será múltiples filas. Definir las claves de la fila de encabezado.

5 Consulta MongoDB con Condiciones (Esta pregunta utiliza la colección (transacciones) creadas en el Ejercicio 3)

	1 Encuentra cualquier registro donde Nombre es Tom

	2 Encuentre cualquier registro donde el monto de pago total (Pago.Total) es 400.

	3 Encuentre cualquier registro donde el precio (Transaction.price) sea mayor que 400.

	4 Busque cualquier registro donde Note sea nulo o falte la clave.

	5 Encuentre cualquier registro donde exista Nota y su valor sea nulo.

	6 Encuentra cualquier registro donde no exista la clave de nota.

6 Agregación con MongoDB (Esta pregunta utiliza la colección (transacciones) creadas en el Ejercicio 3.)

	1 Calcule el monto total de la transacción sumando Pago. Total en todos los registros.

	2 Obtenga el precio total por registro sumando los valores de precio en la matriz de Transacción (Transaction.price).

	3 Calcule los pagos totales (Pago.Total) para cada tipo de pago (Tipo de pago).

	4 Encuentra la identificación máxima.

	5 Encuentra el precio máximo (Transaction.price).
7 Operaciones CRUD (Esta pregunta utiliza la colección (transacciones) creadas en el Ejercicio 3. )

CRUD: Crear, Leer, Actualizar y Eliminar.

	1 Inserte un registro a continuación.

	2 Actualizando el nuevo registro insertado arriba. Hacer nombre = ’Registro actualizado’ & Note = ’¡Actualizado!’

	3 Elimine el registro insertado arriba utilizando Id.

8 Creación de usuario

	1 Cree un usuario de solo lectura que pueda consultar registros de colecciones de todas las bases de datos.

	2 Cree un usuario escritor que pueda crear colecciones y realizar operaciones CRUD en cualquier colección.

	3 Cree un usuario administrado por el usuario que pueda realizar la operación de escritura en la base de datos administrada por el usuario y lea solo para el resto de las bases de datos.

### Datos JSON

```json
[
{
    "Id": 100,
    "Name": "John",
    "TransactionId": "tran1",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 200
    },
    {
    "ItemId":"a110",
    "price": 200   
    }
  ],
  "Subscriber": true,
  "Payment": {
    "Type": "Credit-Card",
    "Total": 400,
    "Success": true
  },
  "Note": "1st Complete Record"
},
{
    "Id": 101,
    "Name": "Tom",
    "TransactionId": "tran2",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 200
    },
    {
    "ItemId":"a110",
    "price": 200   
    }
  ],
  "Subscriber": true,
  "Payment": {
    "Type": "Debit-Card",
    "Total": 400,
    "Success": true
  },
  "Note":null
},
{
    "Id": 102,
    "Name": "Margaret",
    "TransactionId": "tran3",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 200
    },
    {
    "ItemId":"a110",
    "price": 200   
    }
  ],
  "Subscriber": true,
  "Payment": {
    "Type": "Credit-Card",
    "Total": 400,
    "Success": true
  }
},
{
    "Id": 103,
    "Name": "Dylan",
    "TransactionId": "tran4",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 200
    },
    {
    "ItemId":"a110",
    "price": 200   
    }
  ],
  "Subscriber": true,
  "Payment": null,
  "Note": "Payment is Null"
}
]
```
Aquí está el archivo JSON para upsert en el ejercicio 3-3.
```json
[
{
    "Id": 100,
    "Name": "ZZZZZZ",
    "TransactionId": "tran1",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 2000000000
    },
    {
    "ItemId":"a110",
    "price": 200   
    }
  ],
  "Subscriber": true,
  "Payment": {
    "Type": "Credit-Card",
    "Total": 400,
    "Success": true
  },
  "Note": "1st Complete Record"
},
{
    "Id": 101,
    "Name": "Tom",
    "TransactionId": "tran2",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 200
    },
    {
    "ItemId":"a110",
    "price": 200   
    }
  ],
  "Subscriber": true,
  "Payment": {
    "Type": "Debit-Card",
    "Total": 400,
    "Success": true
  },
  "Note":null
},
{
    "Id": 102,
    "Name": "Margaret",
    "TransactionId": "tran3",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 200
    },
    {
    "ItemId":"a110",
    "price": 200   
    }
  ],
  "Subscriber": true,

  "Payment": {
    "Type": "Credit-Card",
    "Total": 400,
    "Success": true
  }
},
{
    "Id": 103,
    "Name": "Dylan",
    "TransactionId": "tran4",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 200
    },
    {
    "ItemId":"a110",
    "price": 200   
    }
  ],
  "Subscriber": true,
  "Payment": null,
  "Note": "Payment is Null"
},
{
    "Id": 104,
    "Name": "Oliver",
    "TransactionId": "tran5",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 200
    },
    {
    "ItemId":"a110",
    "price": 200   
    }
  ],
  "Subscriber": true,

  "Payment": {
    "Total": 400,
    "Success": true
  },
  "Note": "Payment Type is missing"
},
{
    "Id": 105,
    "Name": "Sarah",
    "TransactionId": "tran6",
  "Transaction": [
    {
    "ItemId":"a100",
    "price": 200
    },
    {
    "ItemId":"a110",
    "price": 200
    }
  ],
  "Subscriber": true,
  "Note": "Payment is missing"
}
]
 ```
