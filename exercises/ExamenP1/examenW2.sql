-- oef 1 SA
SELECT salutation, last_name, first_name, street_address
FROM instructors
WHERE street_address = '518 West 120th';


-- oef 2 SA
SELECT salutation, first_name, last_name
FROM students
WHERE last_name = 'Grant'
ORDER BY salutation DESC, first_name;

-- oef 3 SA
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE last_name = 'Allende'
   OR last_name = 'Grant'
   OR salutation = 'Ms .'
ORDER BY last_name, salutation DESC;


-- oef 4 SA
SELECT student_id, section_id, enroll_date, final_grade
FROM enrollments e
WHERE final_grade != 0;

-- oef 5 SA
SELECT concat_ws(' ', first_name, last_name) as "Name", street_address as "Address"
FROM students
WHERE zip = '10048'
   OR zip = '11102'
   OR zip = '11209';

-- oef 6 SA
SELECT student_id, first_name first, last_name last, zip
FROM students
WHERE (first_name = 'Yvonne' AND zip = '11209')
   OR last_name = 'Zuckerberg';

-- oef 7 SA
SELECT description, prerequisite
FROM courses
WHERE prerequisite < 122;

-- oef 8 SA
SELECT salutation, last_name "LAST NAME", first_name "FIRST NAME", phone
FROM instructors
WHERE last_name != 'Schorin';

-- oef 9 SA
SELECT DISTINCT student_id, first_name, last_name
FROM students
WHERE zip = '10025'
ORDER BY student_id;

-- oef 10 SA
SELECT description "desc", prerequisite "pre"
FROM courses
WHERE prerequisite IS NOT NULL
ORDER BY description ASC;

-- oef 11 SA
SELECT description, cost, prerequisite
FROM courses
WHERE cost = 1195.0 AND prerequisite = 20 OR prerequisite = 25;

