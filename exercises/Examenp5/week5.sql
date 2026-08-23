-- oef 1
SELECT count(*) Number_of_enrollments
FROM enrollments;
-- oef 1b
SELECT count(DISTINCT section_id) "Number of different sections"
FROM sections;

-- oef 2
SELECT cost "expensive course"
FROM courses
WHERE cost IS NOT NULL
ORDER BY cost DESC
LIMIT 1;

-- oef 3
SELECT MIN(e.enroll_date) first, MAX(e2.enroll_date) AS "most recent"
FROM enrollments e
         JOIN enrollments e2 ON e.student_id = e2.student_id;

-- oef 4
SELECT COUNT(*) "courses without prerequisite"
FROM courses
WHERE prerequisite IS NULL;

-- oef 5
SELECT count(DISTINCT student_id)
FROM enrollments;

-- oef 6
SELECT min(c.description) "first in order", max(c.description) "last in order"
FROM courses c;

-- oef 7
SELECT MAX(enroll_date) AS "most recent"
FROM enrollments;

-- oef 8
SELECT s.location, count( DISTINCT c.description), s.capacity
FROM sections s
JOIN courses c ON s.course_no = c.course_no
GROUP BY s.location, s.capacity;

-- oef
