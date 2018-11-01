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
-- This selects the field first_name and last_name, of every record, from the table actor.
SELECT first_name, last_name
FROM actor;

-- 1b.
/*
We use the CONCAT function to display multiple fields as one.  Here we concatenate the values of the field first_name with the values of the field last_name, in order to display the full name as one field.  We also wrap the concatenation in an UPPER function, to ensure the query is displayed in uppercase.
*/
SELECT UPPER(CONCAT(first_name, " ", last_name)) AS 'Actor Name'
FROM actor;

/****************************************************************************************************
Section 2
****************************************************************************************************/

-- 2a.
-- This selects the field actor_id, first_name, and last_name, from the table actor, only from records where the field first_name is equal to 'Joe.'
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b.
-- This selects the field first_name and last_name, from the table actor, only from records where 'GEN' appears anywhere in the field last_name.
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c.
/*
This selects the field first_name, and last_name, from the table actor, only from records where 'LI' appears anywhere in the last_name field.  Furthermore, we order the results in alphabetical order by the values of the second field selected- or the last_name field, and thereafter we order by the values of the first field selected- or the first_name field.
*/
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY 2, 1;

-- 2d.
-- This selects the field country_id and country, from the table country, only from records where the value of the country field is equal to any of the following values: Afghanistan, Bangladesh, China.
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
-- EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  
-- We use the ALTER TABLE clause to add a column to our table actor.  The column we add will be used to store a description for each actor.
-- EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  
ALTER TABLE actor
ADD description BLOB;

-- 3b.
-- We use the ALTER TABLE clause to drop the column description from the table actor.
ALTER TABLE actor
DROP COLUMN description;

/****************************************************************************************************
Section 4
****************************************************************************************************/

-- 4a.
-- This selects the field last_name, and counts how many actors have each last name, from the table actor.  We group by last_name.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1;

-- 4b.
-- This selects the field last_name, and counts how many actors have that last name, from the table actor, only for last names that at least 2 actors have.  We group by last_name.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1
HAVING COUNT(last_name) > 1;

-- 4c.
-- This updates the table actor, by changing the value of the field first_name to "HARPO" for any record where actor_id is 172.
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

-- 4d.
-- This updates the table actor, by changing the value of the field first_name to "GROUCHO" for any record where first_name is "HARPO".
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

/****************************************************************************************************
Section 5
****************************************************************************************************/
-- 5
-- EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  
-- The SHOW CREATE TABLE statement is used to show the exact code that produced a table.
-- EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  
SHOW CREATE TABLE actor;

/****************************************************************************************************
Section 6
****************************************************************************************************/

-- 6a.
-- This selects the field first_name and last_name, from the table staff, as well as the field address from the table address, for all records.  We use an inner join on the common column address_id.

SELECT s.first_name AS first_name,
    s.last_name AS last_name,
    a.address
FROM staff AS s
INNER JOIN address AS a
ON s.address_id = a.address_id;

-- 6b.
/*
This shows us how much money each staff member rung up during the month of August 2005.

This selects the field first_name and last_name, from the table staff.  We then return the sum of the field amount from the payment table, of records for the month of August 2005.  We perform an inner join using the common column staff_id, and group by the field first_name.
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
This selects the field title, from the table film, and counts the number of actors in each film, by joining the table film_actor with an inner join, on the common column film_id, and counting the number of fields in the column actor_id, from the table film_actor.  We group by the field first_name. 
*/
SELECT f.title AS film,
    COUNT(fa.actor_id) AS number_of_actors
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
GROUP BY 1;

-- 6d.
/*
This counts the number of films with the title 'Hunchback Impossible' in the inventory.  We use an inner join with the tables film and inventory on the common column film_id, and count all fields where the title field is equal to 'Hunchback Impossible.'
*/

SELECT COUNT(*)
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
WHERE title='Hunchback Impossible';

-- THIS IS AN ALTERNATIVE WAY TO SOLVE 6D USING A SUBQUERY.
-- ASK SOMEONE IF THIS IS A POOR WAY OF ACHIEVING OUR GOAL.
SELECT COUNT(*) AS copies_in_inventory
FROM inventory
WHERE film_id
IN (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);


-- 6e.
/*
This lists each customer, and the total amount they paid on films.

This selects the field field first_name and last_name, from the table customer,and joins the table payment, using an inner join, on the common column customer_id.  We then return the sum of the field amount, from the table payment, and group by last name.
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
SELECT CONCAT(first_name, " ", last_name) AS cusomter_name, 
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
SELECT f.title AS movie_title
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
    INNER JOIN category AS c
    ON fc.category_id = c.category_id
WHERE c.name='Family';

-- 7e.
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
LIMIT 5;

/****************************************************************************************************
Section 8
****************************************************************************************************/

-- 8a.
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
SELECT *
FROM top_category_by_gross_revenue;

-- 8c.
DROP VIEW top_category_by_gross_revenue;