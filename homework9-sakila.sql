/*
In this section we answer each question from part 1.
*/

-- 1a.
SELECT first_name, last_name
FROM actor;

-- 1b.
SELECT CONCAT(first_name, " ", last_name)
AS 'Actor Name'
FROM actor;