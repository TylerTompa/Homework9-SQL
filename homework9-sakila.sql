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
-- This returns the field first_name and last_name, of every record, from the table actor.
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
-- This returns the field actor_id, first_name, and last_name, from the table actor, only from records where the field first_name is equal to "Joe"
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b.
-- This returns the field actor_id, first_name, and last_name, from the table actor, only from records where "GEN" appears anywhere in the last_name field.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c.
/*
This returns the field actor_id, first_name, and last_name, from the table actor, only from records where "LI" appears anywhere in the last_name field.  Furthermore, we order the results in alphabetical order by the values of the third field selected- or the last_name field, and thereafter we order by the values of the second field selected- or the first_name field.
*/
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY 3, 2;

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
-- We use the ALTER TABLE clause to add a column to our actor table.  The column we add will be used to store a description for each actor.
-- EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  EDIT THIS COMMENT.  
ALTER TABLE actor
ADD description BLOB;

-- 3b.
-- We use the ALTER TABLE clause to drop the description column from the table actors.
ALTER TABLE actor
DROP COLUMN description;

/****************************************************************************************************
Section 4
****************************************************************************************************/

-- 4a.
-- We return the field last_name, and calculate how many actors have that last name, from the table actor.  We group by last_name in order to display each unique value of the last_name column one time.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1;

-- 4b.
-- We return the last_name field, and calculate how many actors have that last name, from the table actor, only for last names that at least 2 actors have.  We group by last_name in order to display each unique value of the last_name column one time.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1
HAVING COUNT(last_name) > 1;

-- 4c.
-- We update the table actor, by changing the value of the field first_name to "HARPO" for any record where actor_id is 172.
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

-- 4d.
-- We update the table actor, by changing the value of the field first_name to "GROUCHO" for any record where first_name is "HARPO".
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
-- We return the field first_name and last_name, from the table staff, as well as the field address from the table address, for all records,.  We use a left join on the common column address_id.

SELECT s.first_name AS first_name,
    s.last_name AS last_name,
    a.address
FROM staff as s
LEFT JOIN address as a
ON s.address_id = a.address_id;

-- 6b.
/*
We return the field first_name and last_name,, from the table staff, and use the CONCAT function to display the full name as one field.  We then return the sum of the field amount from the payment table, of records for the month of August 2005, and group by name, so that we can see how much money each staff member rung up during this month.  We perform a left join using the common column staff_id.  
*/
SELECT CONCAT(s.first_name, " ", s.last_name) as staff_member,
    SUM(p.amount) as total_amount_rung_up
FROM staff as s
LEFT JOIN payment as p
ON s.staff_id = p.staff_id
WHERE YEAR(p.payment_date) = 2005
    AND MONTH(p.payment_date) = 8
GROUP BY 1;

-- 6c.
SELECT f.title AS film,
    COUNT(fa.actor_id) AS number_of_actors
FROM film as f
INNER JOIN film_actor as fa
ON f.film_id = fa.film_id
GROUP BY 1;

-- 6d.
SELECT COUNT(*) AS copies_in_inventory
FROM inventory
WHERE film_id
IN (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);


-- 6e.
SELECT c.first_name,
    c.last_name,
    SUM(p.amount)
FROM customer AS c
LEFT JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY 2;

/*
To ensure there are no duplicate values in the last_name column, we ran the following two statements:

SELECT COUNT(last_name)
FROM customer;

SELECT COUNT(DISTINCT last_name)
FROM customer;

Both queries returned the same number.
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
SELECT c.name as category,
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
    SELECT c.name as category,
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