-- oef 1
SELECT s.last_name, z.zip, z.state, z.city
FROM students s
         JOIN zipcodes z ON s.zip = z.zip
WHERE CAST(z.zip as integer) < 03000
ORDER BY zip;

-- oef 2
SELECT s.first_name, s.last_name, s.student_id, e.enroll_date
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
WHERE enroll_date > cast(20210203 as integer);

-- oef 3
SELECT s.course_no, c.description, s.section_no
FROM enrollments e
         JOIN sections s ON e.section_id = s.section_id
         JOIN courses c ON c.course_no = s.course_no
WHERE c.prerequisite IS NULL
ORDER BY course_no, section_no;

-- oef 4
SELECT *
FROM students s
         JOIN enrollments e ON s.student_id = e.student_id
         JOIN sections c ON e.section_id = c.section_id;

-- oef 5
SELECT s.student_id, i.instructor_id, s.zip "Student zip", i.zip "Instructor zip"
FROM students s
JOIN zipcodes z ON z.zip = s.zip
JOIN instructors i ON i.zip = z.zip
WHERE s.zip = i.zip;

-- oef 19
SELECT 	c1.course_no course
     , c1.description
     ,c1.prerequisite ,
    c2.description "description prerequisite"
FROM courses c1
JOIN courses c2 ON (c1.prerequisite = c2.course_no)
ORDER BY 1,3;
