/****************************************************************************************************
Tyler Tompa
2018, October, 31
UNCC Data Analytics Boot Camp Homework 9- SQL
****************************************************************************************************/

/****************************************************************************************************
We first run the USE statement, so that we don't have to specify the database in every subsequent statement we run.
****************************************************************************************************/
USE sakila;

/****************************************************************************************************
Secton 1
****************************************************************************************************/

-- 1a.
/*
This selects the field first_name and last_name,
of every record,
from the table actor.
*/
SELECT first_name, last_name
FROM actor;

-- 1b.
/*
We use the CONCAT function to display multiple fields as one.
Here we concatenate the values of the field first_name with the values of the field last_name,
in order to display the full name as one field.
We also wrap the concatenation in an UPPER function,
to ensure the query is displayed in uppercase.
*/
SELECT UPPER(CONCAT(first_name, " ", last_name)) AS 'Actor Name'
FROM actor;

/****************************************************************************************************
Section 2
****************************************************************************************************/

-- 2a.
/*
This selects the field actor_id, first_name, and last_name,
from the table actor,
only from records where the field first_name is equal to 'Joe.'
*/
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b.
/*
This selects the field first_name and last_name,
from the table actor,
only from records where 'GEN' appears anywhere in the field last_name.
*/
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c.
/*
This selects the field first_name, and last_name,
from the table actor,
only from records where 'LI' appears anywhere in the field last_name.
We order by the field last_name,
and thereafter by the values of the field first_name.
*/
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY 2, 1;

-- 2d.
/*
This selects the field country_id and country,
from the table country,
only from records where the value of the country field is equal to any of the following values: Afghanistan, Bangladesh, China.
*/
SELECT country_id, country
FROM country
WHERE country IN (
    'Afghanistan',
    'Bangladesh',
    'China'
);

/****************************************************************************************************
Section 3
****************************************************************************************************/

-- 3a.
/* 
We use the ALTER TABLE clause to add a column to our table actor.
The column we add will be a BLOB datatype used to store a description for each actor.
*/
ALTER TABLE actor
ADD description BLOB;

-- 3b.
/*
We use the ALTER TABLE clause to drop the column description,
from the table actor.
*/
ALTER TABLE actor
DROP COLUMN description;

/****************************************************************************************************
Section 4
****************************************************************************************************/

-- 4a.
/*
This selects the field last_name,
and counts how many actors have each last name,
from the table actor.
We group by the field last_name.
*/
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1;

-- 4b.
/*
This selects the field last_name,
and counts how many actors have that last name,
from the table actor,
only for last names that at least 2 actors have.
We group by the field last_name.
*/
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1
HAVING COUNT(last_name) > 1;

-- 4c.
/*
This updates the table actor,
by changing the value of the field first_name to "HARPO,"
for any record where the field actor_id is equal to 172.
*/
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

-- 4d.
/*
This updates the table actor,
by changing the value of the field first_name to "GROUCHO,"
for any record where first_name is equal to "HARPO."
*/
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

/****************************************************************************************************
Section 5
****************************************************************************************************/
-- 5
/*  
The SHOW CREATE TABLE statement is used to show the exact code that produced a table.
*/  
SHOW CREATE TABLE actor;

/****************************************************************************************************
Section 6
****************************************************************************************************/

-- 6a.

/*
This shows the first and last name of each staff member, as well as their addess.

This joins the table staff,
with the table address,
using an inner join,
on the common column address_id.
We then select the field first_name, last_name, and address,
of every record,
from our joined table.
*/
SELECT s.first_name AS first_name,
    s.last_name AS last_name,
    a.address
FROM staff AS s
INNER JOIN address AS a
ON s.address_id = a.address_id;

-- 6b.
/*
This shows how much money each staff member rung up during the month of August 2005.

This joins the table staff,
with the table payment,
using an inner join,
on the common column staff_id.
We then select the field first_name and last_name,
and return the sum of the fields in the column amount,
from the joined table
only of records for the month of August 2005.
*/
SELECT s.first_name,  s.last_name,
    SUM(p.amount) AS total_amount_rung_up
FROM staff AS s
INNER JOIN payment AS p
ON s.staff_id = p.staff_id
WHERE YEAR(p.payment_date) = 2005
    AND MONTH(p.payment_date) = 8
GROUP BY 1;

-- 6c.
/*
This shows each film, and how many actors are listed for that film.

This joins the table film,
with the table film_actor,
using an inner join,
on the common column film_id.
We then select the field title,
and count the number of fields in the actor_id column
from the joined table,
We group by the field first_name. 
*/
SELECT f.title AS film,
    COUNT(fa.actor_id) AS number_of_actors
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
GROUP BY 1;

-- 6d.
/*
This shows how many copies of the film Hunchback Impossible are in the inventory.

This joins the table film,
with the table inventory,
using an inner join,
on the common column film_id.
We then count the number of fields,
in our joined table,
only for records where the title field is equal to 'Hunchback Impossible.'
*/

SELECT COUNT(*)
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
WHERE title='Hunchback Impossible';

-- 6e.
/*
This lists each customer, and the total amount they paid on films.

This joins the table customer,
with the table payment,
using an inner join,
on the common column customer_id.
We then select the field first_name and last_name,
and return the sum of the fields in the column amount
from the joined table.
We group by the field last name.
*/
SELECT c.first_name,
    c.last_name,
    SUM(p.amount)
FROM customer AS c
INNER JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY 2;

/*
To ensure there are no duplicate values in the last_name column, we ran the following two statements:

SELECT COUNT(last_name)
FROM customer;

SELECT COUNT(DISTINCT last_name)
FROM customer;

Both queries returned the same number, so we can confidently use a GROUP BY clause in our previous statement.
*/

/****************************************************************************************************
Section 7
****************************************************************************************************/

-- 7a.
SELECT title
FROM film
WHERE (title
    LIKE 'k%'
    OR title
    LIKE 'q%'
    )
AND language_id
IN ( 
    SELECT language_id
    FROM language
    WHERE name = 'English'
    )
;

-- 7b.
/*
This shows every actor who appears in the film Alone Trip.

This selects the field first_name, and last_name,
from the table actor,
only of actors whose actor_id,
is in a list of every actor_id, 
from the table film_actor,
only of every film whose film_id,
is in a list of every film_id,
from the table film,
whose title is 'Alone Trip'
*/
SELECT first_name, last_name
FROM actor
WHERE actor_id
IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id
    IN (
        SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
        )
)
;

-- 7c
/*
This shows all Canadian customers.

This joins the table customer,
with the table address,
using an inner join,
on the common column address_id,
from the tables customer and address,
and thereafter joins the table city
using an inner join,
on the common column city_id,
from the tables address and city,
and finally joins the table country,
using an inner join,
on the common column country_id,
from the tables city and country.
We then select the field first_name, last_name, and email,
from the joined table,
only for records where the field country is equal to 'Canada'
*/
SELECT first_name, last_name, 
    email
FROM customer AS cu
INNER JOIN address AS a
ON cu.address_id = a.address_id
    INNER JOIN city AS ci
    ON a.city_id = ci.city_id
        INNER JOIN country AS co
        ON ci.country_id = co.country_id
WHERE country = 'Canada';

-- 7d.
/*
This selcts the title of every film whose category is Family.

This joins the table film,
with the table film_category
using an inner join,
on the common column film_id,
from the tables film and film_category,
and thereafter joins the table category
using an inner join
on the common column category_id
form the tables film_category and category.
We then select the field title,
from the joined table,
ony for records where the field name is equal to 'Family.'
*/
SELECT f.title AS movie_title
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
    INNER JOIN category AS c
    ON fc.category_id = c.category_id
WHERE name='Family';

-- 7e.
/*
This shows the most frequently rented movies in descending order.

This joins the table inventory,
with the table rental,
using an inner join,
on the common column inventory_id,
from the tables rental and inventory,
and thereafter joins the table film,
using an inner join
on the common column film_id,
from the tables inventory and film.
We then select the field title,
and count the number of times each title appears,
from the joined table.
We group by the field title,
and order by the column counting the number of titles.
*/
SELECT f.title AS movie_name,
    COUNT(f.title) AS times_rented
FROM rental AS r
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id
    INNER JOIN film AS f
    ON i.film_id = f.film_id
GROUP BY 1
ORDER BY 2 DESC;

-- 7f
/*
This shows how much business- in dollars- each store brought in.

This joins the table store,
with the table inventory,
using an inner join,
on the common column store_id,
from the tables store and inventory,
and thereafter joins the table rental,
using an inner join,
on the common column inventory_id,
from the tables inventory and rental
and finally joins the table payment,
using an inner join,
on the common column rental_id,
from the tables rental and payment.
We then select the field store_id,
and return the sum of the fields in the column amount,
from the joined_table.
We group by the field store_id.
*/
SELECT s.store_id AS store_id,
    SUM(p.amount) AS total_money_made
FROM store AS s
INNER JOIN inventory AS i
ON s.store_id = i.store_id
    INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
        INNER JOIN payment AS p
        ON r.rental_id = p.rental_id
GROUP BY 1;

-- 7g.
/*

PICK UP HERE PICK UP HERE PICK UP HERE PICK UP HERE PICK UP HERE PICK UP HERE PICK UP HERE PICK UP HERE PICK UP HERE PICK UP HERE PICK UP HERE PICK UP HERE 
This shows the store ID, city, and country, for each store.

This join the table store,
with the table address,
using an inner join,
on the common column address_id,
from the tables store and address,
and thereafter joins the table city,
using an inner join,
on the common column city_id,
from the tables aadress and city,
and finally joins the table country,
using an inner join,
on the common column country_id,
from the tables city and country.
We then select the field store_id, city, and country,
of every record,
from the joined table.
*/
SELECT s.store_id AS store_id,
    ci.city AS city,
    co.country AS country
FROM store AS s
INNER JOIN address AS a
ON s.address_id = a.address_id
    INNER JOIN city AS ci
    ON a.city_id = ci.city_id
        INNER JOIN country AS co
        ON ci.country_id = co.country_id;

-- 7h
/*
This shows the top five genres in gross revenue in descending order.

This joins the table category,
with the table film_category,
using an inner join,
on the common column category_id,
from the tables category and film_category,
and thereafter joins the table inventory,
using an inner join,
on the common column film_id,
from the tables film_category and inventory,
and thereafter joins the table rental,
using an inner join,
on the common column inventory_id,
from the tables inventory and rental,
and finally joins the table payment,
using an inner join,
on the common column rental_id,
from the tables rental and payment.
We then select the field name,
and find the sum of the fields in the column amount.
We group by the field name,
and order by the field showing the sum of the fields in the column amount,
in descending order,
and limit to the first 5 records.
*/
SELECT c.name AS category,
    SUM(p.amount)
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id
    INNER JOIN inventory AS i
    ON fc.film_id = i.film_id
        INNER JOIN rental AS r
        ON i.inventory_id = r.inventory_id
            INNER JOIN payment AS p
            ON r.rental_id = p.rental_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

/****************************************************************************************************
Section 8
****************************************************************************************************/

-- 8a.
-- This creates a view of the last statement so that we can easily query the top five categories again.
CREATE VIEW top_category_by_gross_revenue
AS (
    SELECT c.name AS category,
        SUM(p.amount)
    FROM category AS c
    INNER JOIN film_category AS fm
    ON c.category_id = fm.category_id
        INNER JOIN inventory AS i
        ON fm.film_id = i.film_id
            INNER JOIN rental AS r
            ON i.inventory_id = r.inventory_id
                INNER JOIN payment AS p
                ON r.rental_id = p.rental_id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 5
);

-- 8b.
/*
This selects every field,
from every record,
from the view top_category_by_gross_revenue,
that we created in part 8a.
*/
SELECT *
FROM top_category_by_gross_revenue;

-- 8c.
/*
This deletes the view top_category_by_gross_revenue,
that we created in problem 8a.
*/
DROP VIEW top_category_by_gross_revenue;