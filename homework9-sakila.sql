/****************************************************************************************************
We first run the USE statement, so that we don't have to specify the database in every subsequent statement we run.
****************************************************************************************************/
USE sakila;


/****************************************************************************************************
Secton 1
****************************************************************************************************/

-- 1a.
-- This returns the first_name and last_name field of every record, from the table actor.
SELECT first_name, last_name
FROM actor;

-- 1b.
/*
We use the CONCAT function to display multiple fields as one.  Here we concatenate the values of the first_name field with the values of the last_name field, in order to display the full name as one field.
We also wrap the concatenation in an UPPER function, to ensure the query is displayed in uppercase.
*/
SELECT UPPER(CONCAT(first_name, " ", last_name))
AS 'Actor Name'
FROM actor;

/****************************************************************************************************
Section 2
****************************************************************************************************/

-- 2a.
-- This returns the actor_id, first_name, and last_name field, from the table actor, only from records where the first_name field is equal to "Joe"
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b.
-- This returns the actor_id, first_name, and last_name field, from the table actor, only from records where "GEN" appears anywhere in the last_name field.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c.
/*
This selects the actor_id, first_name, and last_name field, from the table actor, only from records where "LI" appears anywhere in the last_name field.  Furthermore, we order the results in alphabetical order by the values of the third field selected- or the last_name field, and thereafter we order by the values of the second field selected- or the first_name field.
*/
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY 3, 2;

-- 2d.
-- This selects the country_id, and the country field, from the table country, only from records where the value of the country field is equal to any of the following values: Afghanistan, Bangladesh, China.
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
We use the ALTER TABLE clause here to add a column to our actor table.  The column we add will be used to write a description for each actor.
*/
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
-- We return the last_name column, and calculate how many actors have that last name, from the table actor.  We group by last_name in order to display each unique value of the last_name column one time.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1;

-- 4b.
-- We return the last_name column, and calculate how many actors have that last name, from the table actor, only for last names that at least 2 actors have.  We group by last_name in order to display each unique value of the last_name column one time.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1
HAVING COUNT(last_name) > 1;

-- 4c.
-- We update the actor table, by changing the value of the first_name field to "HARPO" for any record where actor_id is 172.
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

-- 4d.
-- We update the actor table, by changing the value of the first_name field to "GROUCHO" for any record where first_name is "HARPO".
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

/****************************************************************************************************
Section 5
****************************************************************************************************/
-- 5
-- The SHOW CREATE TABLE statement is used to show the exact code that produced a table.
SHOW CREATE TABLE actor;