-- Oefening 1 --

SELECT d.department_id,
       d.department_name,
       p.project_id,
       p.project_name,
       p.location
FROM departments d
JOIN projects p ON d.department_id = p.department_id
ORDER BY department_id, project_id;

-- Oefening 2 --

SELECT d.department_id,
       d.manager_id,
       e.last_name,
       e.salary,
       e.parking_spot
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id
ORDER BY 1;        -- ORDER BY 1; Is sorteren op kolom 1 --

-- Oefening 3 --

SELECT p.project_name, p.location,
       CONCAT_WS(' ', e.first_name, e.infix,e.last_name),
       e.department_id
FROM projects p
JOIN tasks t ON p.project_id = t.project_id
JOIN employees e ON t.employee_id = e.employee_id
ORDER BY 4, e.last_name, p.location;

-- Oefening 4 --

SELECT p.project_name, p.location,
       CONCAT_WS(' ', e.first_name, e.infix,e.last_name),
       e.department_id "Department of Employee",
       d.department_id "Department supporting the project"
FROM projects p
         JOIN tasks t ON p.project_id = t.project_id
         JOIN employees e ON t.employee_id = e.employee_id
         JOIN departments d ON p.department_id = d.department_id
WHERE lower(p.location) = 'eindhoven'
OR lower(d.department_name) = 'administration'
ORDER BY 5;

-- Oefening 5 --

SELECT CONCAT_WS(' ', e.first_name, e.infix, e.last_name) employee_name,
       fm.name,
       fm.gender,
       TO_CHAR(fm.birth_date, 'DD-MM-YYYY') "Date of Birth"
FROM employees e
    join family_members fm ON e.employee_id = fm.employee_id
WHERE lower(fm.relationship) IN ('son', 'daughter') -- De 2e kolom zijn de kinderen van de employees --
ORDER BY fm.birth_date; -- Het sorteert nu op datums & bij order by 4; sorteert het op de volgorde van de eerste dag --

-- Oefening 6 --

