-- oef 1
SELECT student_id
FROM students
EXCEPT
SELECT student_id
FROM enrollments;

-- oef 2
SELECT course_no
FROM courses
EXCEPT
SELECT course_no
FROM sections;

-- oef 3a
SELECT last_name, 'student' AS status
FROM students
UNION ALL
SELECT last_name, 'instructor' AS status
FROM instructors;

-- oef 3b
SELECT last_name, 'student' AS status
FROM students
UNION
SELECT last_name, 'instructor' AS status
FROM instructors;

-- oef 4
SELECT first_name
FROM students
INTERSECT
SELECT first_name
from instructors;

-- oef 5
SELECT s.zip, z.city, z.state
FROM students s
         JOIN zipcodes z ON z.zip = s.zip
INTERSECT
SELECT i.zip, z.city, z.state
FROM instructors i
         JOIN zipcodes z ON i.zip = z.zip;

-- oef 6
SELECT course_no
FROM courses
WHERE prerequisite IS NOT NULL
INTERSECT
SELECT course_no
FROM sections
GROUP BY course_no
HAVING COUNT(*) >= 5;

-- oef 7
SELECT student_id, section_id
FROM enrollments
EXCEPT
SELECT student_id, section_id
FROM grades;

-- oef 8
SELECT c2.course_no
FROM courses c2
         JOIN courses c1 ON (c1.prerequisite = c2.course_no)
EXCEPT
SELECT course_no
FROM sections;

-- oef 9
SELECT ROUND(AVG(COALESCE(cost, 0))) "average cost"
FROM courses;

-- oef 10
SELECT COALESCE(TO_CHAR(prerequisite,'99999999'),'geen') prerequisite, COUNT(*) num_course
FROM courses
GROUP BY prerequisite
ORDER BY 1 DESC

-- oef 11
SELECT c1.course_no cursus, c1.description course_desc, c1.prerequisite, c2.course_no, c2.prerequisite FROM courses c1
JOIN sections s ON (c1.course_no = s.course_no)
JOIN courses c2 ON c1.prerequisite = c2.course_no;
