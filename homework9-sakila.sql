/*
Secton 1.
*/

-- 1a.
SELECT first_name, last_name
FROM actor;

-- 1b.
SELECT CONCAT(first_name, " ", last_name)
AS 'Actor Name'
FROM actor;

/*
Section 2
*/

-- 2a.
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c.
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY 3, 2;

-- 2d.
SELECT country_id, country
FROM country
WHERE country IN (
    'Afghanistan',
    'Bangladesh',
    'China'
    )
;

/*
Section 3
*/

--3a.
ALTER TABLE actor
ADD description BLOB;

--3b.
ALTER TABLE actor
DROP COLUMN description;

/*
Section 4.
*/

--4a.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1;

--4b.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY 1
HAVING COUNT(last_name) > 1;

--4c.
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;

--4d.
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';