set search_path = "public";


-- oef 1
SELECT project_id, project_name
FROM projects
WHERE project_id IN (SELECT project_id
                     FROM tasks
                     WHERE hours IS NOT NULL
                     GROUP BY project_id
                     HAVING COUNT(employee_id) > 3)
ORDER BY project_id;


SELECT p.project_id, p.project_name
FROM projects p
         JOIN tasks t ON p.project_id = t.project_id
WHERE hours IS NOT NULL;

-- oef 2
SELECT employee_id, last_name
FROM employees
WHERE employee_id IN (SELECT DISTINCT employee_id
                      FROM tasks t
                               JOIN projects p ON t.project_id = p.project_id
                      WHERE UPPER(location) = 'EINDHOVEN')
ORDER BY employee_id DESC;

-- oef 3
-- a)
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (SELECT employee_id
                      FROM tasks
                      WHERE hours > 10
                        AND project_id IN
                            (SELECT project_id
                             FROM projects
                             WHERE UPPER(project_name) = 'ORDERMANAGEMENT'))
ORDER BY 1;

-- b)
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (SELECT t.employee_id
                      FROM tasks t
                               JOIN projects p ON t.project_id = p.project_id
                      WHERE hours > 10
                        AND UPPER(project_name) = 'ORDERMANAGEMENT')
ORDER BY 1;

-- oef 4
-- a)
SELECT employee_id, last_name
FROM employees
WHERE employee_id IN
      (SELECT employee_id
       FROM family_members
       WHERE UPPER(relationship) IN ('SON', 'DAUGHTER')
       GROUP BY employee_id
       HAVING COUNT(*) >= 2)
ORDER BY 1 DESC;

-- oef 5
-- Welke afdeling heeft de hoogste loonkost?
SELECT department_id, department_name
FROM departments
WHERE department_id IN
      (select department_id
       FROM employees
       GROUP BY department_id
       HAVING SUM(salary) =
              (SELECT MAX(loontabel.loonkost)
               FROM (SELECT SUM(salary) loonkost
                     FROM employees
                     GROUP BY employees.department_id) loontabel));

-- alternatieve manier (de mijne is beter)😎
SELECT SUM(salary)
FROM employees
GROUP BY department_id
ORDER BY sum(salary) DESC
    FETCH FIRST 1 ROW
WITH TIES;

-- oef 6
SELECT *
FROM EMPLOYEES
WHERE employee_id NOT IN (SELECT manager_id
                          FROM EMPLOYEES);

-- 1) Gebruik van de COALESCE-functie
SELECT *
FROM EMPLOYEES
WHERE employee_id NOT IN (SELECT COALESCE(manager_id, 'Geen manager')
                          FROM EMPLOYEES);

-- 2) Gebruik NOT NULL
SELECT *
FROM employees
WHERE employee_id NOT IN (SELECT manager_id
                          FROM employees);

-- 3) Gebruik van OUTER JOIN:
SELECT man.*
FROM employees e
         RIGHT JOIN employees man ON (e.manager_id = man.employee_id)
WHERE e.employee_id IS NULL

-- 4) Gebruik van EXISTS:

-- oef 7
-- Wie heeft er evenveel kinderen als medewerker 'BOCK'?
SELECT e.employee_id, e.last_name, COUNT(*)
FROM employees e
JOIN family_members fm ON (e.employee_id = fm.employee_id)
WHERE UPPER(relationship) IN ('SON', 'DAUGHTER')
AND UPPER(last_name) != 'BOCK'
GROUP BY e.employee_id, e.last_name
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM employees e
    JOIN family_members fm ON (e.employee_id = fm.employee_id)
    WHERE UPPER(relationship) IN ('SON', 'DAUGHTER')
    AND UPPER(e.last_name) = 'BOCK'
    );
