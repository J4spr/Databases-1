-- CONVENTIE: <prefix>_<tabelnaam>_<optioneel_kolomnaam>
-- PRIMARY KEY - prefix pk, geen kolom
-- CHECK - prefix ch
-- FOREIGN KEY - fk
-- UNIQUE - un

-- oef 2
INSERT INTO departments(department_id, department_name)
VALUES (15, 'Human Resources');

INSERT INTO locations
VALUES (15, 'Antwerpen');

-- oef 3
ALTER TABLE departments
    ALTER COLUMN department_name TYPE varchar(25);

-- oef 4
ALTER TABLE projects
ADD CONSTRAINT ch_upper_projects
    CHECK ( project_name = upper(project_name) );

-- oef 5


