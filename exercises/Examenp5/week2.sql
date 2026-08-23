-- oef 1
SELECT salutation, last_name, first_name, street_address
FROM instructors
WHERE street_address = '518 West 120th';

-- oef 2
SELECT salutation, first_name, last_name
FROM students
WHERE lower(last_name) = 'grant'
ORDER BY salutation DESC, first_name;

-- oef 3
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE lower(salutation) like 'ms%'
  AND (lower(last_name) = 'allende' OR lower(last_name) = 'grant')
ORDER BY last_name;

-- oef 4
SELECT student_id, section_id, enroll_date, final_grade
FROM enrollments
WHERE final_grade != 0;

-- oef 5
SELECT * FROM