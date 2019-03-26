-- 1a. Muestra el nombre y apellidos de todos los actores de la tabla "actor.
select first_name, last_name from actor;


-- 1b. Muestra el nombre y apellido de cada actor en una sola columna en mayúsculas. Nombra a la columna "Actor Name"
select concat(first_name,' ', last_name) as 'Actor Name' from actor;


-- 2a. Encuentra el número de ID, nombre y apellido de un actor, del cual solo sabes su nombre, "Joe".
--      Que consulta unica usarias para obtener esta información?
select actor_id, first_name, last_name from actor
where first_name="Joe";


-- 2b. Encuentra todos los actores cuyo apellido contiene las letras GEN:
select first_name, last_name from actor
where last_name like '%GEN%';


-- 2c. Encuentra todos los actores cuyos apellidos contengan las letras LI. Al mismo tiempo, ordena las celdas por apellido y nombre, en este orden:
select first_name, last_name from actor
where last_name like '%LI%'
order by last_name, first_name;


-- 2d. Usando IN muestra las columnas "country_id" y "country" de los siguientes paises: Afghanistan, Bangladesh, and China:
select country_id, country from country where country In ('Afghanistan','Bangladesh','China');


-- 3a. Añade una columna llamada "middle_name" a la tabla "actor". Posiciónala entre "first_name" y "last_name". Pista: Tendrás que especificar el tipo de dato.
alter table actor add middle_name VARCHAR(60) after first_name;


-- 3b. Te das cuenta de que algunos de los actores tienen apellidos tremendamente largos
--  Cambia el tipo de dato de la columna "middle_name" a "blobs"
alter table actor modify middle_name blob;


-- 3c. Ahora borra la columna "middle_name"
alter table actor drop column middle_name;


-- 4a. Lista los apellidos de los actores, asi como cuantos actores tienen apellido.
select distinct last_name, count(last_name) from actor
group by last_name;


-- 4b. Lista los apellidos de los actores y el número de actores quienes tienen apellido,
--     pero solo para aquellos nombres que son compartidos con al menos dos actores
select distinct last_name, count(last_name) from actor
group by last_name
having (count(first_name)>1);


 -- 4d. Es posible que nos hayamos precipitado cambiando GROUCHO a HARPO. Resulta que GROUHCO era el nombre
-- correcto después de todo! 
-- En una sola consilta, si el primer nombre del actor es actualmente HARPO, 
-- cambialo por GROUCHO. Por otra parte, cambia el nombre a MUCHO GROUCHO, que es lo que seria exatamente
-- el actor con el gravísimo error. TEN CUIDADOD DE NO CAMBIAR EL NOMBRE DE TODOS LOS ACTORES
-- A MUCHO GROUCHO! 
-- (Pista: actualiza el dato usando un identificador único.)
NO HACER;
 
-- 5a. No puedes localizar el esquema de la tabla "addreess". Que consulta usarias para recrearla?
describe address;


-- 6a. Usa JOIN para mostrar los nombres y apellidos, así como las direcciones, de todos los miembros de staff. Usa las tablas "staff" y "address":
select staff.first_name, staff.last_name, address.address 
from staff
inner join address
on staff.address_id=address.address_id;


-- 6b. Usa JOIN para mostrar la cantidad total ganada por cada miembro del staff en Agosto de 2015. Usa las tablas "staff" y "payment".
select first_name, amount, payment_date
from staff
inner join payment
on payment.staff_id=staff.staff_id
where year(payment_date)=2005
and month(payment_date)=08;


-- 6c. Lista cada película y el número de actores que estan apuntados para esa película. Usa las tablas "film_actor" y "film". Usa inner join.
select title, count(actor_id) as 'Num. Actores'
from film_actor
inner join film
on film_actor.film_id=film.film_id
group by title;


-- 6d. Cuantas copias de la película Hunchback Impossible existen en el sistema de inventario?
select film.title, count(inventory.film_id) 
from inventory
inner join film
on inventory.film_id=film.film_id
where title ='Hunchback Impossible'
group by inventory.film_id;


-- 6e. Usanto las tablas "payment" y "customer" y el comando JOIN, lista el total pagado por cada cliente. 
--     Lista los clientes alfabéticamente por apellido.
select customer.first_name, customer.last_name, sum(payment.amount)
from payment
inner join customer
on payment.customer_id=customer.customer_id
group by customer.customer_id
order by customer.last_name;


-- 7a. La musica de Queen y Kris Kristofferson han obtenido un resurgimiento inesperado. Como consecuencia inesperada,
--  las películas comenzando por las letras K y Q se han disparado en popularidad. Usa subconsultas para mostrar los títulos
--  de las películas que comienzan por las letras K y Q cuyo idioma es "English".
select F.title,L.name
from film F
inner join language L
on L.language_id=F.language_id
where L.name='English'
and substring(F.title,1,1)='K' or substring(F.title,1,1)='Q';


-- 7b. Usa subconsultas para mostrar todos los actores que aparezcan en la película Alone Trip.
select distinct a.actor_id, a.first_name,a.last_name
from actor a
inner join film_actor fa
on a.actor_id=fa.actor_id
where a.actor_id in(
				select fa.actor_id 
				from film_actor fa
				inner join film
                on film.film_id=fa.film_id
				where film.title='Alone Trip');
                        

-- 7c. Quieres lanzar una campaña de marketing por e-mail en Canadá, para lo cual necesitarás saber los nombres y
--     las direcciones de e-mail de todos los clientes canadienses.
--     Usa joins para obtener esta información
select c.first_name, c.last_name, c.email, c.address_id, ad.city_id
from customer c
inner join address ad
on c.address_id=ad.address_id
where ad.city_id in(select ci.city_id
					from city ci
					inner join country co
					on ci.country_id=co.country_id
					where co.country='Canadá');

select c.first_name, c.last_name, c.email,cc.country
from customer c
inner join address ad
on c.address_id=ad.address_id
inner join (select ci.city_id, co.country
					from city ci
					inner join country co
					on ci.country_id=co.country_id
					where co.country='Canadá') as cc
on ad.city_id = cc.city_id;

-- 7d. Las ventas han bajado en las familias jóvenes, y quieres marcar como objetivo todas las peliculas familiares para una promoción.
--  Identifica todas las películas categorizadas como "family films". Rating:G
select title, rating from film
where rating='G' or rating='PG';

-- 7e. Muestra las más frecuentemente alquiladas peliculas en orden descendiente
select count(inventory.film_id) as 'Num. veces alquiladas', inventory.film_id, film.title
from inventory
inner join rental 
on inventory.inventory_id=rental.inventory_id
inner join film
on film.film_id=inventory.film_id
group by film_id
order by count(inventory.film_id) desc
limit 0,10; -- para mostrar el top 10

-- 7f. Escribe una consulta para mostrar cuanto negocio, en dolares, ha traído cada tienda
select sum(payment.amount) 
from payment 
inner join staff on staff.staff_id=payment.staff_id
inner join rental on rental.staff_id=staff.staff_id
inner join store on store.manager_staff_id=rental.staff_id
group by store.store_id;

-- 7g. Escribe una consulta para mostrar, por cada tienda, su ID, ciudad y país

-- 7h. Lista los 5 generos mas rentables en orden descendiente 
-- (Pista: puede que necesites usar las siguientes tablas: "category, film_category, inventory, payment, and rental".)

-- 8a. En tu nuevo rol como ejecutivo, te gustaría tener una forma más fácil de ver 
--     los 5 géneros más rentables. Usa la solución del problema anterior para crear una vista. 
--     Si aun no has resuelto el 7º, puedes sustituirlo por cualquier otra consulta para crear una vista

-- 8b. Como mostrarías la vista que has creado en el 8a?

-- 8c. Encuentras que no necesitas la vista de los 5 generos. Escribe una consulta para borrarla.