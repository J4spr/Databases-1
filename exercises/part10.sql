SELECT t.project_id, t.employee_id, t.hours
FROM tasks t
WHERE hours < (SELECT AVG(hours)
               FROM tasks
               WHERE project_id = t.project_id);


-- oef 2
SELECT e.manager_id, employee_id, salary
FROM employees e
WHERE (e.manager_id, e.salary) IN (SELECT manager_id, MAX(salary)
                                   FROM employees
                                   WHERE e.employee_id = e.employee_id
                                   group by manager_id);

-- oef 3
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
WHERE EXISTS (SELECT 'x'
              FROM employees
              where e.manager_id = e.manager_id);

SELECT d.department_id, d.department_name
FROM departments d
WHERE NOT EXISTS(SELECT 'x'
                 FROM employees
                 WHERE department_id = d.department_id
                   AND parking_spot IS NOT NULL);

-- oef 13
ALTER TABLE projects
    DROP CONSTRAINT pk_projects CASCADE,
    ALTER COLUMN project_id SET DATA TYPE INTEGER,
    ALTER COLUMN project_id
        ADD GENERATED ALWAYS
        AS IDENTITY (START WITH 40 INCREMENT BY 10);
ALTER TABLE projects
    ADD CONSTRAINT pk_projects PRIMARY KEY (project_id);
ALTER TABLE tasks
    ALTER COLUMN project_id SET DATA TYPE INTEGER,
    ADD CONSTRAINT fk_tasks_project_id
        FOREIGN KEY (project_id)
            REFERENCES projects (project_id);

-- GROUP BY
SELECT d.department_id, d.department_name
FROM departments d
         JOIN employees e ON e.department_id = d.department_id
WHERE parking_spot IS NULL
GROUP BY d.department_id
HAVING count(*) = 0;

-- oef 14
-- Alle employees die aan project 20 meer dan 10 uur werkten krijgen een loonsverhoging van 5%.
UPDATE employees e
SET salary = e.salary * 1.05
FROM tasks t
WHERE e.employee_id = t.employee_id
  AND t.hours > 10
  AND project_id = 20;
-- manier 2
UPDATE employees e
SET salary = e.salary * 1.05
FROM tasks t
WHERE e.employee_id IN (SELECT employee_id
                        FROM tasks
                        WHERE t.hours > 10
                          AND project_id = 20);


-- oef 15
-- Zorg dat salarissen kleiner dan 100.000 euro worden toegelaten.
-- Employees met kinderen krijgen per kind een loonsverhoging van 50 euro/maand. (opgelet : salaris
-- bevat het jaarinkomen van een medewerker).
ALTER TABLE employees
    DROP CONSTRAINT IF EXISTS ck_salary,
    ADD CONSTRAINT ch_employees_salary
        CHECK ( salary <= 100000 );

UPDATE employees e
SET salary = salary + 50 * 12 * (SELECT COUNT(*)
                                 FROM family_members fm
                                 WHERE UPPER(relationship) IN ('SON', 'DAUGHTER')
                                   AND employee_id = e.employee_id)
FROM family_members fm2
WHERE e.employee_id = fm2.employee_id
  AND UPPER(relationship) IN ('SON', 'DAUGHTER');

-- oef 16
-- Voeg een nieuw project toe aan de tabel PROJECTEN.
-- Projectnaam: ‘Saneringen’
-- Locatie: Maastricht
-- Ondersteunende afdeling: de afdeling die tot nog toe het meest aantal projecten ondersteunde.
INSERT INTO projects (project_name, location, department_id)
VALUES ('Saneringen', 'Maastricht',
        (SELECT department_id
         FROM projects
         GROUP BY department_id
         HAVING COUNT(project_id) = (SELECT MAX(cnt_proj.cntproj)
                                     FROM (SELECT COUNT(project_id) cntproj
                                           FROM projects
                                           GROUP BY department_id) AS cnt_proj)));

INSERT INTO projects (project_name, location, department_id)
VALUES ('Saneringen', 'Maastricht',
        (SELECT department_id
         FROM projects
         GROUP BY department_id
         ORDER BY COUNT(project_id) DESC
             FETCH NEXT 1 ROW ONLY));



CREATE INDEX ind_employees_departments ON employees (department_id);

SELECT *
FROM employees
where department_id = 3;

SET enable_seqscan TO OFF