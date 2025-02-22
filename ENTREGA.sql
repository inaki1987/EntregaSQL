--EJERCICIO 1 --
--Se entrega imagen de estructura de datos en el README--

--EJERCICIO 2.Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.--

SELECT "title"
FROM "film" 
WHERE "rating"='R';

--EJERCICIO 3.Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40--
--Se incluyen los valores extremos de actor_id--
SELECT "first_name", "last_name"
FROM "actor"
WHERE "actor_id"<= 40
AND "actor_id">= 30;

--EJERCICIO 4.Obtén las películas cuyo idioma coincide con el idioma original.--

SELECT "title"
FROM "film"
WHERE 'language_id'='original_laguage_id';
 --No existe ninguna pelicula con valor 'original_laguage_id', todos vienen informados con el valor NULL, de la misma manera todos los valores de 'language_id' son iguales a 1.
SELECT "film_id", "title", "language_id", "original_language_id"
FROM "film" ; 

-- EJERCICIO 5.Ordena las películas por duración de forma ascendente. 
SELECT "title", "length"
FROM "film"
ORDER BY "length" ASC;

-- EJERCICIO 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.--

SELECT "first_name", "last_name"
FROM "actor"
WHERE "last_name"='ALLEN';

-- EJERCICIO 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.
SELECT "rating" ,count(*) AS"Quantity"
FROM "film"
GROUP BY "rating";

-- EJERCICIO 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
SELECT "title"--"rating","length"
FROM "film"
WHERE "rating"='PG-13'
	OR "length">180;

-- EJERCICIO 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT round(AVG("replacement_cost"),2) AS "Media",
	round(VARIANCE("replacement_cost"),2) AS "Varianza",
	round(STDDEV("replacement_cost"),2) AS "Desviación estandar"
FROM "film";

-- EJERCICIO 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT MAX("length")AS "maxima duración", Min("length")AS "minima duración"
FROM "film";


-- EJERCICIO 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT "amount" 
FROM "payment"
ORDER BY "payment_date" DESC 
LIMIT 1 OFFSET 2;

-- EJERCICIO 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC- 17’ ni ‘G’ en cuanto a su clasificación.
SELECT "title", "rating" 
FROM "film"
WHERE "rating"<>'NC-17'
AND "rating"<>'G';

-- EJERCICIO13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT Round(avg("length"),2)AS "Promedio", "rating"AS "Clasificación"
FROM "film"
GROUP BY "rating";

-- EJERCICIO14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT "title","length"
FROM "film"
WHERE "length">180;

-- EJERCICIO15. ¿Cuánto dinero ha generado en total la empresa?
SELECT sum("amount")
FROM "payment"

-- EJERCICIO16. Muestra los 10 clientes con mayor valor de id.
SELECT "customer_id", "first_name", "last_name"
FROM "customer"
ORDER BY "customer_id" DESC 
LIMIT 10;

-- EJERCICIO17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
SELECT "first_name", "last_name"
FROM "actor" AS a
INNER JOIN "film_actor" AS fa ON a.actor_id=fa.actor_id
INNER JOIN "film"AS f ON fa.film_id=f.film_id 
WHERE "title"='EGG IGBY';

--comprobamos paso a paso el ejercicio 17
SELECT "film_id","title"
FROM "film"
WHERE "title"='EGG IGBY';

SELECT "actor_id"
FROM "film_actor"
WHERE "film_id"=274;

SELECT "first_name", "last_name"
FROM "actor"
WHERE "actor_id"=20
	OR "actor_id"=38
	OR "actor_id"=50
	OR "actor_id"=154
	OR "actor_id"=162;


--18. Selecciona todos los nombres de las películas únicos.
SELECT distinct "title"
FROM "film";


--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
SELECT "title", "length"
FROM "film" AS f
INNER JOIN "film_category" AS fc ON f.film_id=fc.film_id
INNER JOIN "category"AS c ON fc.category_id=c.category_id 
WHERE "name"='Comedy'
	AND "length">180; 

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT "name"AS "Categoria",round(AVG("length"),2)AS "Promedio"
FROM "category" AS c
INNER JOIN "film_category" AS fc ON c.category_id=fc.category_id
INNER JOIN "film"AS f ON fc.film_id=f.film_id 
GROUP BY c.name
HAVING AVG("length") >'110';


--21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG("return_date"-"rental_date")
FROM "rental";

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT "first_name"||' '|| "last_name"
FROM "actor";

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT "rental_date", COUNT("rental_id") 
FROM "rental"
GROUP BY "rental_date"
ORDER BY count("rental_date") DESC ;

--24. Encuentra las películas con una duración superior al promedio.
SELECT "title", "length"
FROM "film"
WHERE length>(SELECT AVG("length")
				FROM "film");

--25. Averigua el número de alquileres registrados por mes.
SELECT to_char("rental_date", 'YYYY-MM'), count("rental_id")
FROM "rental"
GROUP BY to_char("rental_date", 'YYYY-MM')
ORDER BY to_char("rental_date", 'YYYY-MM');

--select count ("rental_id")
--from rental;

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT round(AVG("amount"),2) AS "Media",
	round(VARIANCE("amount"),2) AS "Varianza",
	round(STDDEV("amount"),2) AS "Desviación estandar"
FROM "payment";

--27. ¿Qué películas se alquilan por encima del precio medio?
SELECT "title","rental_rate"
FROM "film"
WHERE "rental_rate">(SELECT AVG("rental_rate")
						FROM "film");
--select AVG("rental_rate")
--from "film";

--28. Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT "actor_id"
FROM "film_actor"
GROUP BY "actor_id"
HAVING  count("actor_id")>40;

--COMPROBACIÓN-select "actor_id",count("actor_id")
--from"film_actor"
--group by "actor_id";

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT i.film_id, "title", count (i.film_id) AS "cantidad disponible"
FROM "inventory" AS i
INNER JOIN "film" AS f ON f.film_id=i.film_id
GROUP BY i.film_id, f.title
ORDER BY f.title ASC;

--30. Obtener los actores y el número de películas en las que ha actuado.
SELECT a.first_name, a.last_name, count(fa.actor_id)
FROM "film_actor"AS fa
INNER JOIN "actor" AS a ON fa.actor_id=a.actor_id
GROUP BY fa.actor_id,a.first_name, a.last_name;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT f.title, a.FIRST_NAME ,a.LAST_NAME 
FROM "film" AS f
LEFT JOIN "film_actor" AS fa ON f.film_id=fa.FILM_ID
INNER JOIN "actor"AS a ON fa.actor_id=a.actor_id
ORDER BY f.TITLE ;


--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT  a.FIRST_NAME ,a.LAST_NAME,f.title
FROM "actor" AS a
LEFT JOIN "film_actor" AS fa ON a.actor_id=fa.actor_ID
INNER JOIN "film" AS f ON fa.film_id=f.film_id
ORDER BY a.FIRST_NAME ;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT f.title, r.rental_id, r.rental_date
FROM "film" AS f
LEFT JOIN "inventory" AS i ON f.film_id=i.FILM_ID 
INNER JOIN "rental" AS r ON i.inventory_id=r.INVENTORY_ID 
ORDER BY f.title, r.rental_date

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT "customer_id",sum ("amount")
FROM "payment"
GROUP BY "customer_id" 
ORDER BY SUM ("amount")DESC
LIMIT 5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT "first_name", "last_name"
FROM "actor"
WHERE "first_name"='JOHNNY';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
SELECT "first_name"AS "Nombre", "last_name" AS "Apellido"
FROM "actor"
WHERE "first_name"='JOHNNY';

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT  Min("actor_id")AS "minima id",MAX("actor_id")AS "maxima id"
FROM "actor"

--38. Cuenta cuántos actores hay en la tabla “actor”.
SELECT count("actor_id")
FROM actor

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT "first_name", "last_name"
FROM actor
ORDER BY "last_name","first_name" ASC

--Dentro del apellido, ordenamos tambien por orden alfabetico de nombre

--40. Selecciona las primeras 5 películas de la tabla “film”.
SELECT "film_id","title"
FROM Film
LIMIT 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
SELECT "first_name", count("first_name")
FROM "actor"
GROUP BY "first_name"
ORDER BY Count("first_name") DESC;

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT r.rental_id, c.first_name, c.last_name
FROM "rental" AS r
INNER JOIN "customer" AS c ON r.customer_id=c.customer_id;

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
SELECT c.customer_id, c.first_name, c.last_name, r.rental_id
FROM "customer" AS c
LEFT JOIN "rental"AS r ON c.customer_id=r.customer_id
ORDER BY c.customer_id;

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT f.title, c.name
FROM "film"AS f
CROSS JOIN "category" AS c;

--Esta consulta no aprota valor, ya que la categoría es una característica intrinseca de la pelicula y estamos haciendo todas las posibles combinadciones entre el nombre de la pelicula (en este caso) con los diferentes tipos de pelicula que hay)
--El sentido que podría tener es realizar dos inner join, para que junto con la pelicula, a traves de la tabla intermedia "film_category", apareciera la clasificación de cada una de las películas. 

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT distinct(a.first_name), a.last_name
FROM "actor" AS a
INNER JOIN "film_actor" AS fa ON a.actor_id=fa.ACTOR_ID 
INNER JOIN "film" AS f ON fa.film_id=f.FILM_ID
INNER JOIN "film_category" AS fc ON f.film_id=fc.film_id
INNER JOIN "category" AS c ON fc.category_id=c.CATEGORY_ID 
WHERE c.name='Action'
ORDER BY a.first_name;

--Se añade el distintc para eliminar duplicados

--46. Encuentra todos los actores que no han participado en películas.
SELECT a.actor_id,"first_name", "last_name"
FROM "actor" AS a
LEFT JOIN "film_actor" AS fa ON a.actor_id=fa.actor_id;


--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT a.first_name, a.last_name, count(fa.actor_id)
FROM "film_actor"AS fa
INNER JOIN "actor" AS a ON fa.actor_id=a.actor_id
GROUP BY fa.actor_id,a.first_name, a.last_name;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas AS 
SELECT a.first_name, a.last_name, count(fa.actor_id)
FROM "film_actor"AS fa
INNER JOIN "actor" AS a ON fa.actor_id=a.actor_id
GROUP BY fa.actor_id,a.first_name, a.last_name;
--Vemos el resultado
SELECT *
FROM actor_num_peliculas;

--49. Calcula el número total de alquileres realizados por cada cliente.
SELECT  c.first_name, c.last_name, count("rental_id")
FROM "rental" AS r
INNER JOIN "customer" AS c ON r.customer_id=c.customer_id
GROUP BY c.customer_id
ORDER BY count(r.rental_id) DESC;

--50. Calcula la duración total de las películas en la categoría 'Action'.
SELECT c.name, sum(f.length)
FROM "film"AS f
INNER JOIN "film_category"AS fc ON f.film_id=fc.FILM_ID 
INNER JOIN "category"AS c ON fc.category_id=c.category_id 
GROUP BY c.name
HAVING c.name ='Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporal AS
SELECT "customer_id", count("rental_id")
FROM "rental"
GROUP BY "customer_id";
--Vemos el resultado
SELECT *
FROM "cliente_rentas_temporal";


--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas AS
SELECT f.title, count(r.rental_id)
FROM "film" AS f
INNER JOIN "inventory" AS i ON f.film_id=i.film_id
INNER JOIN "rental" AS r ON i.inventory_id=r.inventory_id
GROUP BY f.title
HAVING count("rental_id")>10;
--Vemos el resultado
SELECT *
FROM peliculas_alquiladas;


--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

SELECT f.title
FROM "film" AS f
INNER JOIN inventory AS i ON f.film_id=i.FILM_ID 
INNER JOIN rental AS r ON i.inventory_id=r.INVENTORY_ID 
INNER JOIN customer AS c ON r.CUSTOMER_ID =c.customer_id
WHERE (r.return_date IS NULL
AND c.first_name='TAMMY'
AND c.last_name='SANDERS')
ORDER BY f.title;


--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
SELECT distinct(a.actor_id), a.FIRST_NAME ,a.LAST_NAME
FROM "actor" AS a
INNER JOIN "film_actor" AS fa ON a.actor_id=fa.actor_ID
WHERE fa.actor_id IN(SELECT actor_id
					FROM "film_actor"
					INNER JOIN film AS f ON fa.film_id=f.film_id
					WHERE f.film_id IN (SELECT film_id
										FROM "film_category" AS fc
										INNER JOIN "category" AS c ON fc.category_id=c.category_id
										WHERE c.name = 'Sci-Fi'))
ORDER BY a.last_name;



--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido
SELECT Distinct(a.actor_id),a.first_name, a.last_name
FROM "actor" AS a
INNER JOIN "film_actor" AS fa ON a.actor_id=fa.actor_id 
INNER JOIN "film" AS f ON fa.FILM_ID =f.FILM_ID 
INNER JOIN "inventory" AS i ON f.FILM_ID =i.FILM_ID 
INNER JOIN "rental" AS r ON i.inventory_id =r.inventory_id 
WHERE r.rental_date>(SELECT min(r.rental_date)
					FROM "rental" AS r
					INNER JOIN inventory AS i ON r.inventory_id=i.inventory_id 
					INNER JOIN film AS f ON i.film_id=f.film_id 
					WHERE f.title ='SPARTACUS CHEAPER')
ORDER BY a.last_name;


-- otra manera de resolver el 55
SELECT Distinct(a.actor_id),a.first_name, a.last_name
FROM "actor" AS a
WHERE a.actor_id IN (SELECT fa.actor_id
					FROM "film_actor" AS fa
					WHERE fa.film_id IN (SELECT i.film_id
										FROM "inventory"AS i 
										INNER JOIN rental AS r ON i.inventory_id=r.inventory_id 
										WHERE r.rental_date>(SELECT min(r.rental_date)
																	FROM "rental" AS r
																	INNER JOIN inventory AS i ON r.inventory_id=i.inventory_id 
																	INNER JOIN film AS f ON i.film_id=f.film_id 
																	WHERE f.title ='SPARTACUS CHEAPER'))) 
ORDER BY a.last_name;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

SELECT distinct (a.actor_id), a.first_name, a.last_name
FROM "actor" AS a
WHERE actor_id NOT IN (SELECT distinct (a.actor_id)
						FROM "actor" AS a
						INNER JOIN "film_actor" AS fa ON a.actor_id=fa.ACTOR_ID 
						INNER JOIN "film" AS f ON fa.film_id=f.film_id
						INNER JOIN "film_category" AS fc ON f.FILM_ID=fc.film_id
						INNER JOIN "category" AS c ON fc.category_id=c.CATEGORY_ID 
						WHERE c.name ='Music')
ORDER BY a.actor_id;

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
SELECT distinct(f.title)
FROM "film" AS f 
INNER JOIN "film_category" AS fc ON fc.film_id=f.film_id 
INNER JOIN "inventory"AS i ON f.film_id=i.film_id
INNER JOIN "rental"AS r ON i.inventory_id=r.inventory_id
GROUP BY f.title,r.return_date, r.rental_date
HAVING (r.return_date::DATE-r.RENTAL_DATE::DATE)>8
;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
SELECT "title"
FROM "film"
WHERE "film_id" IN (SELECT "film_id"
					FROM "film_category"
					WHERE "category_id"IN(SELECT "category_id"
											FROM "category"
											WHERE "name"='Animation'));
											
--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
SELECT "title"
FROM "film"
WHERE "length"=(SELECT "length"
				FROM "film"
				WHERE "title"='DANCING FEVER')
ORDER BY "title";

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
SELECT c.first_name,c.last_name, count(distinct(i.film_id))
FROM "customer" AS c
INNER JOIN "rental" AS r ON c.customer_id=r.customer_id
LEFT JOIN "inventory"AS i ON r.inventory_id=i.inventory_id
GROUP BY c.first_name, c.last_name
HAVING count(DISTINCT(i.film_id))>6
ORDER BY c.first_name;

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT c.name, count (r.rental_id)
FROM "category" AS c
INNER JOIN "film_category" AS fc ON c.category_id=fc.category_id
INNER JOIN "film" AS f ON fc.film_id=f.film_id 
INNER JOIN "inventory"AS i ON f.film_id=i.film_id
INNER JOIN "rental"AS r ON i.inventory_id=r.inventory_id
GROUP BY c.name;

--62. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT c.name, count(f.film_id)
FROM "film"AS f
INNER JOIN "film_category"AS fc ON f.film_id=fc.FILM_ID 
INNER JOIN "category"AS c ON fc.category_id=c.category_id 
GROUP BY c.name, f.RELEASE_YEAR
having f.RELEASE_YEAR =2006;



--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT  concat(Staff.first_name, staff.last_name), address.address
FROM "staff"
CROSS JOIN "store" AS s
INNER JOIN address ON s.address_id=address.address_id;

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT c.customer_id, c.first_name, c.last_name, count("rental_id")
FROM "rental" AS r
INNER JOIN "customer" AS c ON r.customer_id=c.customer_id
GROUP BY c.customer_id
ORDER BY count(r.rental_id) DESC;