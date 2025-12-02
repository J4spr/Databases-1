-- demo oef
SELECT initcap(first_name)
FROM employees
UNION
SELECT initcap(substring(name for position(' ' in name) - 1))
FROM family_members;

-- oef 1
SELECT to_char(birth_date, 'YYYY/MM/DD')
FROM employees
UNION ALL
SELECT to_char(birth_date, 'YYYY/MM/DD')
FROM family_members
ORDER BY 1;

-- oef 2
SELECT to_char(birth_date, 'YYYY/MM/DD')
FROM employees
UNION
SELECT to_char(birth_date, 'YYYY/MM/DD')
FROM family_members;

UPDATE family_members
SET birth_date = to_date(1965 / 09 / 01, 'YYYY/MM/DD')
WHERE birth_date = to_date(1965 / 09 / 01, 'YYYY/MM/DD');

-- oef 3
SELECT employee_id
FROM employees
EXCEPT
select employee_id
from family_members;

-- oef 3a
SELECT e.employee_id,
       e.first_name,
       to_char(e.birth_date, 'YYYY-MM-DD'),
       COALESCE(fm.name, 'single')
FROM employees e
         LEFT JOIN family_members fm ON e.employee_id = fm.employee_id
WHERE UPPER(relationship) = 'PARTNER'
   OR fm.name IS NULL;

-- oef 4
SET TIMEZONE = 'Europe/Brussels';

SELECT CASE
           WHEN date_part('minute', to_timestamp('25/11/2025 16:30', 'DD/MM/YYYY HH24:MI') -
                                    CURRENT_TIMESTAMP) > 0
               THEN 'De les is nog bezig'
           ELSE 'De les is gedaan'
           END;

-- oef 3b
SELECT p.location, SUM(t.hours) "Totaal uren",
        CASE WHEN SUM(t.hours) < 50 THEN 'Project on time'
        WHEN SUM(t.hours) BETWEEN 50 AND 80 THEN 'Project takes longer than expected'
        ELSE 'Project overdue'
        END "project timing"
FROM projects p
LEFT JOIN tasks t ON p.project_id = t.project_id
GROUP BY p.location
ORDER BY 2 DESC;
