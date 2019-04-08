# Mysql
https://dev.mysql.com/doc/refman/5.7/en/

## Modelo relacional
* Todos los datos se representan en forma de tablas (también llamadas “relaciones”). La tabla es además la unidad de almacenamiento principal.
* Las tablas están compuestas por filas (o registros) y columnas (o campos) que almacenan cada uno de los registros.
* Las filas y las columnas, en principio, carecen de orden a la hora de ser almacenadas. Existen índices que permiten la ordenación física de los datos.
* El orden de las columnas lo determina cada consulta (que se realizan usando SQL).
* Cada tabla debe poseer una clave primaria. El identificador único de cada registro puede esta compuesto por una o más columnas.
* La relación entre dos tablas requiere incluir en una de ellas la clave primaria de la otra. Se le llama clave externa.


## Tablas

### Tipos de tablas (ENGINE)
* **InnoDB** Versatilidad, transaciones, relaciones entre tablas
* **MyISAM** Gran almacenamiento de datos, sin transaccion
* **MERGE** Multiples tablas virtuales tipo MyISAM
* **MEMORY (HEAP)** Tablas temporales 
* **ARCHIVE** Almacenamiento en archivos
* **CSV** Almacenamient en archivos CSV (Comma separatted values). No admite nulos
* **FEDERATED** Almacenamiento remoto


## Tipos de dato
### Tipos numéricos
* **TINYINT**	A very small integer
* **SMALLINT**	A small integer
* **MEDIUMINT**	A medium-sized integer
* **INT**	A standard integer
* **BIGINT**	A large integer
* **DECIMAL**	A fixed-point number
* **FLOAT**	A single-precision floating point number
* **DOUBLE**	A double-precision floating point number
* **BIT**	A bit field

### Tipo boolean
* **BOOLEAN** <==> TINYINT(1)

### Datos cadena / imagenes o ficheros
* **CHAR**	A fixed-length nonbinary (character) string
* **VARCHAR**	A variable-length non-binary string
* **BINARY**	A fixed-length binary string
* **VARBINARY**	A variable-length binary string
* **TINYBLOB**	A very small BLOB (binary large object)
* **BLOB**	A small BLOB
* **MEDIUMBLOB**	A medium-sized BLOB
* **LONGBLOB**	A large BLOB
* **TINYTEXT**	A very small non-binary string
* **TEXT**	A small non-binary string
* **MEDIUMTEXT**	A medium-sized non-binary string
* **LONGTEXT**	A large non-binary string
* **ENUM**	An enumeration; each column value may be assigned one enumeration member
* **SET**	A set; each column value may be assigned zero or more SET members

### Datos de fecha y hora
* **DATE**	A date value in CCYY-MM-DD format
* **TIME**	A time value in hh:mm:ss format
* **DATETIME**	A date and time value inCCYY-MM-DD hh:mm:ssformat
* **TIMESTAMP**	A timestamp value in CCYY-MM-DD hh:mm:ss format
* **YEAR**	A year value in CCYY or YY format

### Datos geográficos
* **GEOMETRY**	A spatial value of any type
* **POINT**	A point (a pair of X-Y coordinates)
* **LINESTRING**	A curve (one or more POINT values)
* **POLYGON**	A polygon
* **GEOMETRYCOLLECTION**	A collection of GEOMETRYvalues
* **MULTILINESTRING**	A collection of LINESTRINGvalues
* **MULTIPOINT**	A collection of POINTvalues
* **MULTIPOLYGON**	A collection of POLYGONvalues
### Documentos
* **JSON** Optimización de almacenamieto y consulta

## Vistas 
Consultas predefinidas que se visualizan como tablas

## Procedimientos
Pequeñas rutinas que permiten operar con los datos y realizar operaciones.


## Primary & Foreing keys
* **Primary key** Establece una combinacion de campos que identifican una registro de una tabla.
* **Foreing key** Relación entre tablas, campos que identifican un registro en otra tabla. Relaciones padre-hijo.
## Relaciones entre tablas

### Relación 1-N
Los hijos solo tienen un padre, pero un padre solo puede tener un hijo

Ejemplo: Tabla Animal - Especie

Un animal solo puede pertenecer a una especie, pero cada especie puede tener distintos animales.
### Relacion N-M
Los hijos pueden tneer varios padres y los padres varios hijos

Ejemplo Tabla Alumnos - Clases 

Un alumno puede asistir a varias clases y una clase puede tener varios alumnos

### Relación 1-1
Solo hay una relación unitaria

Ejemplo: Tabla Productos - Imagen Producto 

Se separa la información de un producto se separa en varios tablas para reducir su peso

Tabla Alumno
Tabla AlumnoUsuario
Tabla Clase
Tabla AlumnoClase
Tabla AlumnoNotas




Instruciones de mantenimiento y definición
 Select Database
 
 #### CREATE DATABASE / CREATE SCHEMA
 ```
 create database hackabos;
 create schema hackabos;
 ```
 #### DROP DATABASE
 ```
 drop database hackabos;
 drop schema [if exists] hackabos;
 ```
 #### USE DATABASE
 ```
 use hackabos;
 ``` 
#### Manage Databases
```
show variables;
show databases;
show tables;

```

#### Create tables
[Definición](https://dev.mysql.com/doc/refman/5.7/en/create-table.html)
```
create table nombre (
 campo1 tipo restricciones,
 campo2 tipo restricciones,
 campo3 tipo restricciones,
 PRIMARY KEY  (campo1),
 CONSTRAINT `fk_tablaorigen_tabla_destino` FOREIGN KEY (campo3) REFERENCES nombrepadre (campokey) ON DELETE RESTRICT ON UPDATE CASCADE

) ENGINE=InnoDB DEFAULT CHARSET=utf8;

campo1 INT NOT NULL DEFAULT 0 
campo2 VARCHAR(20) NULL
campo3 INT NOT NULL AUTO_INCREMENT 

create table name like othertable;
create table name select * from othertable;

CREATE TEMPORARY TABLE new_tbl SELECT * FROM orig_tbl LIMIT 0;
```
#### ALTER TABLE
```
ALTER TABLE table_name ADD PRIMARY KEY(primary_key_column);
ALTER TABLE table_name ADD UNIQUE INDEX nombreindice (campo1 ASC) ;
ALTER TABLE table_name ADD CONSTRAINT nombreindice UNIQUE (campo1, campo2);
ALTER TABLE table_name CHANGE old_column_name new_column_name new_column_definition;

ALTER TABLE table_name ADD COLUMN nuevacol DECIMAL(2,1) NULL AFTER viejacol;
ALTER TABLE table_name DROP COLUMN viejacol;
ALTER TABLE table_name RENAME TO nuevonombre;
```
#### DROP 
``` 
drop table table_name;
truncate table table_name;
```


#### Import/Export
http://downloads.mysql.com/docs/sakila-db.tar.gz
```
SOURCE //home/sakila-db/sakila-schema.sql;
SOURCE //home/sakila-db/sakila-data.sql;

mysqldump -u [user] -p [db_name] | gzip > [filename_to_compress.sql.gz] 

gunzip < [compressed_filename.sql.gz]  | mysql -u [user] -p[password] [databasename] 

mysql -u username -p < example.sql
```

#### Consultas basicas CRUD
https://hackernoon.com/mysql-tutorial-query-limit-offset-condition-row-foreign-key-join-select-d3835b28e1a
**Select**

```
SELECT 
    column_1, column_2, ...
FROM
    table_1
[INNER | LEFT |RIGHT] JOIN table_2 ON conditions
WHERE
    conditions
GROUP BY column_1
HAVING group_conditions
ORDER BY column_1
LIMIT offset, length;

```
* =	
* <>  !=	
* <
* \>	
* <=	
* \>=	
* BETWEEN
* LIKE
* IN
* IS NULL

* AVG
* MAX
* MIN
* SUM
* COUNT

* DISTINCT
* CASE, IF
* ISNULL

```
COALESCE(value1,value2,...);
GREATEST(value1, value2, ...);
LEAST(value1,value2,...);
```

* DATEDIFF
* NOW
* MONTH
* STR_TO_DATE
* DATE_FORMAT
* DATE_ADD

```
SELECT 
    DATE_ADD('1999-12-31 00:00:01',
        INTERVAL 1 DAY) result;  
```

* CONCAT	
* LENGTH & CHAR_LENGTH
* LEFT	
* REPLACE	
* SUBSTRING
* TRIM	
* FIND_IN_SET	
* FORMAT



**Insert**
```
INSERT INTO table(c1,c2,...)
VALUES 
   (v11,v12,...),
   (v21,v22,...),
    ...
   (vnn,vn2,...);

   INSERT INTO table_name(column_list)
SELECT 
   select_list 
FROM 
   another_table;
```
**Update**
```
UPDATE [LOW_PRIORITY] [IGNORE] table_name 
SET 
    column_name1 = expr1,
    column_name2 = expr2,
    ...
WHERE
    condition;

    UPDATE T1, T2,
[INNER JOIN | LEFT JOIN] T1 ON T1.C1 = T2. C1
SET T1.C2 = T2.C2, 
    T2.C3 = expr
WHERE condition
```
**Delete**
```
DELETE FROM table_name
WHERE condition;

DELETE T1, T2
FROM T1
INNER JOIN T2 ON T1.key = T2.key
WHERE condition;

TRUNCATE TABLE tabla_name;
```
Optimización de consultas
#### Triggers
DELIMITER ;;
CREATE TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END;;

#### Seguridad (permisos)
```
select * from mysql.users;
CREATE USER 'hackabos'@'localhost' IDENTIFIED BY 'hackabos';
GRANT ALL PRIVILEGES ON *.* TO 'hackabos'@'localhost';
UPDATE user SET plugin='auth_socket' WHERE User='hackabos';

FLUSH PRIVILEGES;
drop user 'hackabos'@'localhost';

show grants for 'hackabos';
grant SELECT, UPDATE, DELETE ON table.* TO hackabos;

```

#### Diseño de una base de datos normalizada
Creación de una base de datos de ejemplo para el siguiente módulo

### Direcciones útiles
* https://dev.mysql.com/doc/employee/en/employees-installation.html
* http://www.ntu.edu.sg/home/ehchua/programming/sql/sampledatabases.html
* http://www.mysqltutorial.org/
* https://repository.genmymodel.com/diagrams/database

