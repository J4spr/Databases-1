-- oef 1 SA
SELECT s.last_name, z.zip, z.state, z.city
FROM students s
         JOIN zipcodes z
              ON s.zip = z.zip
WHERE cast(z.zip AS INT) < 03000
ORDER BY z.zip;

-- oef 2 SA
SELECT s.first_name, s.last_name, s.student_id, e.enroll_date
FROM enrollments e
         JOIN students s ON e.student_id = s.student_id
WHERE enroll_date < '03-02-2021'
ORDER BY s.last_name;

-- oef 4 SA
-- SELECT *
-- FROM courses c
-- JOIN students s ON

-- oef 5 SA
SELECT s.student_id, i.instructor_id, s.zip AS "student zip", i.zip AS "Instructor zip"
FROM students s
         JOIN instructors i ON s.zip = i.zip;

-- oef 6 SA
SELECT c.course_no AS course, section_no AS section, e.student_id AS student
FROM courses c
         JOIN sections s ON c.course_no = s.course_no
         JOIN enrollments e ON s.section_id = e.section_id
         JOIN students st ON st.student_id = e.student_id;

-- oef 7 SA
SELECT concat_ws(' ', i.first_name, i.last_name),
       i.street_address,
       i.zip,
       to_char(s.start_date_time, 'YYYY-MM-DD'),
       s.section_no
FROM sections s
         JOIN instructors i ON s.instructor_id = i.instructor_id
WHERE to_char(s.start_date_time, 'YYYY-MM-DD') > '2021-04-01'
ORDER BY s.start_date_time;

-- oef 8 SA
SELECT s.student_id, s.first_name, s.last_name
FROM students s
         JOIN zipcodes z ON s.zip = z.zip
WHERE upper(state) = 'CT';

-- oef 9 SA
SELECT concat_ws(' ', s.first_name, s.last_name),
       e.section_id,
       g.grade_type_code AS evaluation_type,
       g.numeric_grade   AS grade
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
         JOIN grades g ON g.student_id = e.student_id
WHERE concat_ws(' ', s.first_name, s.last_name) = 'Daniel Wicelinski'
  AND e.section_id = 87;

-- oef 10 SA
SELECT s.student_id,
       s.first_name,
       s.last_name,
       n.section_id,
       c.course_no,
       g.numeric_grade,
       g.grade_type_code AS letter_grade,
       n.section_id
FROM students s
         JOIN grades g ON s.student_id = g.student_id
         JOIN enrollments e ON e.student_id = s.student_id
         JOIN sections n ON n.section_id = e.section_id
         JOIN courses c ON c.course_no = n.course_no
WHERE c.course_no = 420;

-- oef 11 SA
SELECT s.student_id,
       s.first_name,
       s.last_name,
       n.section_id,
       gw.percent_of_final_grade,
       g.grade_type_code,
       g.numeric_grade
FROM students s
         JOIN enrollments e ON e.student_id = s.student_id
         JOIN sections n ON n.section_id = e.section_id
         JOIN grades g ON g.student_id = s.student_id
         JOIN grade_type_weights gw ON g.section_id = gw.section_id
WHERE g.numeric_grade < 80
ORDER BY s.last_name;

-- oef 12 SA
SELECT c.description, s.section_no, s.location, s.capacity
FROM courses c
         JOIN sections s ON c.course_no = s.course_no
WHERE s.location = 'L211'
ORDER BY c.description DESC;

-- oef 13 SA
SELECT c.description, n.section_no, n.location, n.capacity
FROM students s
         JOIN enrollments e ON e.student_id = s.student_id
         JOIN sections n ON e.section_id = n.section_id
         JOIN courses c ON n.course_no = c.course_no
WHERE concat_ws(' ', s.first_name, s.last_name) = 'Joseph German';

-- oef 14 SA
SELECT DISTINCT c.course_no, c.description, n.section_id
FROM grades g
         JOIN enrollments e ON g.section_id = e.section_id
         JOIN sections n ON e.section_id = n.section_id
         JOIN courses c ON n.course_no = c.course_no
         JOIN grade_type_weights gtw ON g.section_id = gtw.section_id
WHERE gtw.percent_of_final_grade >= 25
  AND gtw.grade_type_code = 'PA';

-- oef 15 SA
SELECT s.first_name, s.last_name, g.numeric_grade
FROM students s
         JOIN grades g ON s.student_id = g.student_id
WHERE g.numeric_grade >= 99
  AND g.grade_type_code = 'PJ';

-- oef 16 SA
SELECT s.student_id, s.last_name, s.first_name, g.section_id, g.grade_type_code AS quiz, g.numeric_grade
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE s.zip = '10956'
AND lower(g.grade_type_code) = 'qz';

-- oef 17 SA
SELECT c.course_no, n.section_no, i.first_name, i.last_name
FROM sections n
JOIN instructors i ON i.instructor_id = n.instructor_id
JOIN courses c ON c.course_no = n.course_no
WHERE c.prerequisite = 20
ORDER BY n.course_no, section_no;

-- oef 18 SA
SELECT stud.student_id, i.instructor_id,stud.zip,
       i.zip
FROM students stud JOIN instructors i
                        ON stud.zip = i.zip;

SELECT stud.student_id, i.instructor_id, stud.zip,
       i.zip
FROM students stud
         JOIN enrollments e ON stud.student_id = e.student_id
         JOIN sections sec ON e.section_id = sec.section_id
         JOIN instructors I ON sec.instructor_id =
                               i.instructor_id
WHERE stud.zip = i.zip;

-- oef 21 SA
SELECT i.first_name, i.last_name, i.zip FROM instructors i
JOIN zipcodes z ON i.zip = z.zip
ORDER BY i.zip;

-- oef 22 SA
-- SELECT * FROM sections n
-- JOIN