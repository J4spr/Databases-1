-- oef 1 SA
-- a
SELECT count(*) as number_of_enrollments
FROM enrollments;

-- b
SELECT count(DISTINCT section_id)
FROM enrollments;

-- c
SELECT sum(capacity)        total_capacity,
       round(avg(capacity)) average_capacity,
       min(capacity)        minimum_capacity,
       max(capacity)        maximum_capacity
FROM sections;

-- oef 2 SA
SELECT max(cost)
FROM courses

-- oef 3 SA
SELECT min(enroll_date) first, max(enroll_date) "Most Recent"
FROM enrollments;

-- oef 4 SA
SELECT count(*)
FROM courses
WHERE prerequisite IS NULL;

-- oef 5 SA
SELECT count(DISTINCT student_id)
FROM enrollments;

-- oef 6 SA
SELECT min(description) "First in order", max(description) "Last in order"
from courses;

-- oef 7 SA
SELECT max(enroll_date) "Most recent subscription"
FROM enrollments;

-- oef 8 SA
SELECT location, count(section_id), sum(capacity), min(capacity), max(capacity)
FROM sections
GROUP BY location;

-- oef 9 SA
-- a
SELECT location,
       instructor_id,
       count(section_id) AS "Number of sections",
       sum(capacity)     AS "Tot cap",
       min(capacity),
       max(capacity)
FROM sections
GROUP BY location, instructor_id;

-- b
SELECT location,
       instructor_id,
       count(section_id) AS "Number of sections",
       sum(capacity)     AS "Tot cap",
       min(capacity),
       max(capacity)
FROM sections
GROUP BY location, instructor_id
HAVING sum(capacity) > 50;


-- c
SELECT location,
       instructor_id,
       count(section_id) AS "Number of sections",
       sum(capacity)     AS "Tot cap",
       min(capacity),
       max(capacity)
FROM sections
WHERE course_no > 99
GROUP BY location, instructor_id
HAVING sum(capacity) > 50;

-- d
SELECT location, sum(capacity)
FROM sections
WHERE location LIKE 'L5%'
GROUP BY location
LIMIT 2;

-- oef 10 SA
SELECT student_id, section_id, round(avg(numeric_grade)) avg_grade
FROM grades
WHERE upper(grade_type_code) = 'HM'
GROUP BY student_id, section_id
HAVING avg(numeric_grade) > 80
ORDER BY student_id, section_id;

-- oef 11 SA
SELECT student_id, count(section_id)
FROM enrollments
GROUP BY student_id
having count(section_id) > 2;

-- oef 12 SA
SELECT course_no            "course #",
       avg(capacity)        "Avg. capacity",
       round(avg(capacity)) "Avg. capacity without decimals"
FROM sections
GROUP BY course_no, instructor_id
HAVING instructor_id = 101;

-- oef 13 SA
SELECT cost, count(*)
FROM courses
GROUP BY cost
ORDER BY 1;

-- oef 14 SA
SELECT enroll_date, count(*)
FROM enrollments
WHERE section_id = 90
GROUP BY enroll_date;

-- oef 15 SA
SELECT DISTINCT employer, count(*)
FROM students
GROUP BY employer
ORDER BY count(*) DESC
LIMIT 4;

-- oef 16 SA
SELECT instructor_id, count(*)
FROM sections
GROUP BY instructor_id
ORDER BY instructor_id;

-- oef 17 SA
SELECT section_id, max(numeric_grade)
FROM grades
GROUP BY section_id
HAVING section_id BETWEEN 85 AND 93
ORDER BY section_id;

-- oef 18 SA
SELECT student_id, round(avg(numeric_grade))
FROM grades
GROUP BY student_id
HAVING count(DISTINCT section_id) > 2;

-- oef 19 SA
SELECT zip, count(*)
FROM students
GROUP BY zip
HAVING count(*) > 5;

-- oef 20 SA
SELECT c.course_no, description
FROM courses c
LEFT JOIN sections n ON c.course_no = n.course_no
WHERE c.course_no IS NOT NULL