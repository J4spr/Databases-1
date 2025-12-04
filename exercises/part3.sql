-- Oefening 1 --

SELECT employee_id, birth_date
       --, TO_CHAR(birth_date, 'YYYY/MM/DD'),
       -- age(birth_date),
       -- date_part('year', age(birth_date))
FROM family_members
WHERE UPPER(relationship) IN ('SON', 'DAUGHTER')
AND date_part('year', age(birth_date)) < 18;

-- Oefening 2 --

SELECT employee_id, last_name, location, age(birth_date)
FROM employees
WHERE date_part('year', age(birth_date)) > 30
AND UPPER(location) IN ('MAARSSEN', 'EINDHOVEN');

-- Oefening 3 --

SELECT employee_id, age(birth_date) AS "age partner"
FROM family_members
WHERE UPPER(relationship) = 'PARTNER'
AND date_part('year', age(birth_date)) BETWEEN 35 AND 45;

-- Oefening 4 --

 SELECT first_name, last_name,
        to_char(birth_date, 'DD Month YYYY') AS "Date Of Birth",
        to_char(birth_date+ interval '65 year','FMday FMDD FMmonth YYYY') pension
 FROM employees;

-- Oefening 5 --

SELECT name,
       TO_CHAR(birth_date, 'day DD month YYYY') AS "Born On"
FROM family_members
ORDER BY birth_date DESC;

-- Oefening 5b --

SELECT name,
       TO_CHAR(birth_date, 'FMday FMDD FMmonth YYYY') AS "Born On"
FROM family_members
ORDER BY birth_date DESC;

-- Oefening 5c --

SELECT name,
       TO_CHAR(birth_date, 'TMday TMDD TMmonth YYYY') AS "Born On"
FROM family_members
ORDER BY birth_date DESC;

SET lc_time = 'fr_FR';
SET lc_time = 'en_US';


-- Oefening 6 --

SELECT CONCAT_WS (' ', first_name, infix, last_name)
FROM employees;

-- Oefening 6b -- Periode2 -- COALESCE

SELECT CONCAT(first_name, ' ', infix, ' ', last_name)
FROM employees;







