-- 1 Obtener todos las marcas
select * from Marca;

-- 2 Obtener todos los modelos y su consumo
select Nombre, Consumo from Modelo;

-- 3 Obtener todos los modelos que tengan un consumo >10
SELECT Nombre, Consumo FROM Modelo 
WHERE Consumo>10;

-- 4 Obtener todos los modelos que tenga un consumo entre 8 y 12
select Nombre, Consumo from Modelo 
where Consumo between 8 and 12;

-- 5 Obtener el consumo por modelo cada 1000 km
select Nombre, Consumo, Consumo*10 as Consumo1000 from Modelo;

-- 6 Obtener la media de consumo
select cast(avg(Consumo) as decimal(5,2)) as `Consumo Medio` from Modelo; -- Cast cambia el tipo de dato

-- 7 Obtener la media de consumo de los modelos de Seat
-- select avg(Consumo) as `Consumo Medio` from Modelo where idMarca=2;
select t2.Nombre, avg(Consumo)from Modelo t1
inner join Marca t2 
	on t1.idMarca=t2.idMarca
where t2.Nombre="Seat"
group by t2.Nombre;

-- 7 Contar cuantos modelos que tengan un consumo >10
select count(*) as 'Total de Modelos' from Modelo where Consumo>10;

-- 8 Obtener el modelo y el consumo de los modelos ordenados por mayor a menor consumo y luego por ordenado por nombre de modelo
select Nombre, Consumo from Modelo
order by Consumo desc, Nombre asc;

-- 9 Obtener la tabla original : Matrícula, Marca, Modelo, Consumo y Kilómetros
select Matricula, Ma.Nombre, Mo.Nombre as Modelo, Consumo, Kilometros 
from Vehiculos V
inner join Modelo Mo on V.idModelo=Mo.idModelo
inner join Marca Ma on Mo.idMarca=Ma.idMarca;

-- 10 Obtener el consumo medio por marcas
select Marca.Nombre as Marcas, avg(Consumo)
from Modelo as t1
inner join Marca
	on t1.idMarca=Marca.idMarca
group by Marca.Nombre;

-- 11 Obtener el kilometraje medio por marca.
select Ma.Nombre as Marca, avg(kilometros) as Media
from Vehiculos V
inner join Modelo Mo on Mo.idModelo=V.idModelo
inner join Marca Ma on Ma.idMarca=Mo.idMarca
group by Ma.Nombre;

-- 12 Obtener la matricula del coche con menor kilometraje
select Matricula, kilometros from Vehiculos
order by Kilometros
limit 0,1; -- que coja el primer registro y solo me muestras 1 

select Matricula, kilometros from Vehiculos
where Kilometros=(select min(Kilometros) from Vehiculos);

-- 13 Obtener los modelos con menos consumo de cada marca
select Ma.Nombre, Min(Consumo)
from Modelo Mo
inner join Marca Ma on Ma.idMarca=Mo.idMarca
group by Ma.Nombre;

-- 14 Añadir una nueva marca y dos modelos de esa marca
insert into Marca (idMarca, Nombre) values(6, 'Fiat');
insert into Modelo (Nombre, Consumo, idMarca) values ('R12', 11.2,6);
insert into Modelo (Nombre, Consumo, idMarca) values ('Megane', 16.1,6);

-- 15 Actualizar el modelo 'Carrera' por '911 Carrera'
update Modelo
set Nombre = '911 Carrera' 
where idModelo=2;

update Modelo
set Nombre = '911 Carrera' 
where Nombre='Carrera';

-- 16 Reducir el kilometraje en un 10%
update Vehiculos
set Kilometros=Kilometros*0.9
where Matricula>''; -- le ponemos esta condicion para que nos deje hacerlo

-- 17 Aumentar el consumo en un 5% para los consumos menores a 8.0
update Modelo
set Consumo = Consumo *1.05
where Consumo<8;

-- 18 Modelos que contenga la letra 'a'
select Nombre 
from Modelo
where Nombre like '%a%'; -- not like para mostrar lo contrario

-- 19 Modelos que empiecen con la letra 'C'
select Nombre 
from Modelo
where Nombre like 'C%';

-- 20 Obtener los distintos consumos que hay
select distinct Consumo from Modelo; -- que devuelva los que son distintos

select Consumo from Modelo group by Consumo;

-- 21 Obtener todos los modelos de seat u opel
select Nombre from Modelo
where idMarca in(1,2); -- in sirve para incluir los que indicamos

select Nombre from Modelo
where idMarca=1
	or idMarca=2;

-- 22 Obtener la suma de kilometros por modelo
select Mo.Nombre, sum(Kilometros) 
from Vehiculos Vactoractor_id
inner join Modelo Mo on Mo.idModelo=V.idModelo
group by Mo.Nombre;


