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
WHERE e.employee_id IS NULL;

-- 4) Gebruik van EXISTS:

-- oef 7
-- Wie heeft er evenveel kinderen als medewerker 'BOCK'?
SELECT e.employee_id, e.last_name, COUNT(*)
FROM employees e
         JOIN family_members fm ON (e.employee_id = fm.employee_id)
WHERE UPPER(relationship) IN ('SON', 'DAUGHTER')
  AND UPPER(last_name) != 'BOCK'
GROUP BY e.employee_id, e.last_name
HAVING COUNT(*) = (SELECT COUNT(*)
                   FROM employees e
                            JOIN family_members fm ON (e.employee_id = fm.employee_id)
                   WHERE UPPER(relationship) IN ('SON', 'DAUGHTER')
                     AND UPPER(e.last_name) = 'BOCK');
--- ----------------------------------------------------------------------------------------------
-- VIEWS
CREATE VIEW v_emp_dept_7
AS
SELECT employee_id, last_name, first_name, salary, department_id
FROM employees
WHERE department_id = 7
WITH CHECK OPTION;

DROP VIEW v_emp_dept_7;


UPDATE v_emp_dept_7
SET department_id=7
WHERE employee_id = '999444444';


SELECT *
FROM v_emp_dept_7;

-- oef 8
CREATE OR REPLACE VIEW v_emp_sal_dep
AS
SELECT department_id, SUM(salary) "Total salary cost per departement"
FROM employees
GROUP BY department_id
ORDER BY 1;

SELECT *
FROM v_emp_sal_dep;

-- oef 9
CREATE OR REPLACE VIEW v_emp_child
AS
SELECT e.employee_id,
       CONCAT_WS(' ', e.first_name, e.infix, e.last_name) name_emp,
       TO_CHAR(e.birth_date, 'YYYY-MM-DD')                birth_date,
       fm.name
FROM employees e
         JOIN family_members fm ON (e.employee_id = fm.employee_id)
WHERE UPPER(relationship) IN ('SON', 'DAUGHTER')
ORDER BY 1, fm.name;

SELECT *
FROM v_emp_child;

-- oef 10
-- a
CREATE OR REPLACE VIEW v_emp_salary
AS
SELECT employee_id, first_name, last_name, salary, department_id
FROM employees
ORDER BY salary DESC
WITH CHECK OPTION;

SELECT *
FROM v_emp_salary;
-- oef 11
-- a
CREATE OR REPLACE VIEW v_department
AS
SELECT *
FROM departments;
-- b
ALTER TABLE departments
    ADD COLUMN dept_telephone_number VARCHAR(9);
SELECT *
FROM v_department;

-- d
ALTER TABLE departments
    DROP COLUMN dept_telephone_number;

-- oef 14
INSERT INTO v_emp_salary
VALUES ('999999998', 'Jan', 'Janssens', 35000, 7);

SELECT *
FROM v_emp_salary;

-- oef 15
CREATE OR REPLACE VIEW v_percentage_proportion
AS
SELECT t.employee_id,
       t.project_id,
       COALESCE(ROUND(t.hours / totalhours.projecthours * 100), 0) AS "PROC proportion"
FROM tasks t
         JOIN
     (SELECT project_id, SUM(hours) projecthours
      FROM tasks
      GROUP BY project_id) AS totalhours
     ON (t.project_id = totalhours.project_id)
ORDER BY 2, 1;

SELECT *
FROM v_percentage_proportion;

--COMBO OEFENING
-- Creëer een view v_familieleden_projecten_maastricht die het volgende resultaat oplevert.
-- Geef employee_id, de naam en de leeftijd (in jaren) van de familieleden van de medewerkers die aan een project werken met locatie Maastricht.
-- Los op met 2 subqueries en 1 join.
-- Let op de gevraagde output. Je zal verschillende tekstfuncties moeten gebruiken om dit op te lossen.
-- Plak exact 5 * achter de naam van het familielid.
-- EMPLOYEE_ID | "naam familielid"	                     |"leeftijd familielid"
-- ---------------------------------------------------------------------------
-- 999555555   |Alex***** PARTNER of S. JOCHEMS         |44 jaar oud vandaag
-- 999444444   |Andrew***** SON of W. ZUIDERWEG         |14 jaar oud vandaag
-- 999444444   |Josefine***** DAUGHTER of W. ZUIDERWEG  |16 jaar oud vandaag
-- 999444444   |Suzan***** PARTNER of W. ZUIDERWEG      |37 jaar oud vandaag

CREATE OR REPLACE VIEW v_familieleden_projecten_maastricht
AS
SELECT e.employee_id,
       CONCAT(fm.name, '***** ',
              UPPER(relationship), ' of ',
              SUBSTRING(e.first_name for 1), '. ',
              UPPER(e.last_name))                                         "naam familielid",
       CONCAT(DATE_PART('year', AGE(fm.birth_date)), ' jaar oud vandaag') "leeftijd familielid"
FROM employees e
JOIN family_members fm ON (e.employee_id = fm.employee_id)
WHERE e.employee_id IN (
        SELECT e.employee_id
        FROM tasks
        WHERE project_id IN (
        SELECT project_id
        FROM projects
        WHERE UPPER(location) = 'MAASTRICHT'
    ))
    ORDER BY 2;
SELECT * FROM v_familieleden_projecten_maastricht;