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