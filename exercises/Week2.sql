-- Oefening 1 --

SELECT *
FROM Projects;

-- Oefening 2 --

SELECT project_name, department_id
FROM projects;

-- Oefening 3 a --

SELECT 'project', project_id, 'is handled by', department_id
FROM projects;

-- Oefening 3 b --

SELECT 'project' AS " ", project_id, 'is handled by' AS " ", department_id
FROM projects;

-- Oefening 3 c --
SELECT project_id AS "Projects with departments"
FROM projects;

-- Oefening 10 --

SELECT *
FROM departments
WHERE lower(department_name) = 'administration';

-- Oefening 11 --

SELECT employee_id, last_name, location
FROM employees
WHERE lower(location) = 'maastricht';

-- Oefening 12 --

SELECT employee_id, project_id, hours
FROM tasks
WHERE hours >= 20
AND hours <= 35
AND project_id = 10;

-- OR --

SELECT employee_id, project_id, hours
FROM tasks
WHERE hours BETWEEN 20 and 35
  AND project_id = 10;

-- Oefening 13 --

SELECT project_id, hours
FROM tasks
WHERE employee_id = '999222222'
    AND hours <10;

-- Oefening 14 --

SELECT employee_id, last_name, province
FROM employees
WHERE UPPER(PROVINCE) = 'GR'
   OR UPPER(PROVINCE) = 'NB';

-- Oefening 15 --

SELECT department_id, first_name
FROM employees
WHERE lower(first_name)
          IN ('suzan' , 'martina','douglas','henk')
ORDER BY department_id DESC, first_name ASC;

-- Oefening 16 --

SELECT last_name, salary, department_id
FROM employees
WHERE ( department_id = 7
    AND salary <40000)
OR employee_id = '999666666';





