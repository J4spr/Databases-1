-- oef 1
-- Welke cursussen hebben als prerequisite de cursus ‘Intro to Programming’?
SELECT course_no, description, prerequisite
FROM courses
WHERE prerequisite = (SELECT course_no
                      FROM courses
                      WHERE lower(description) = 'intro to programming');

-- oef 2
-- Geef cursusnr en beschrijving van cursussen die gedoceerd worden door Fernand Hanks.
-- Zuivere subquery schrijven!
SELECT *
FROM courses
WHERE course_no IN (SELECT course_no
                    FROM sections
                    WHERE instructor_id IN (SELECT instructor_id
                                            FROM instructors
                                            WHERE lower(concat_ws(' ', first_name, last_name)) = 'fernand hanks'));


-- oef 3
SELECT student_id, last_name, first_name
FROM students
WHERE student_id IN
      (SELECT student_id
       FROM grades
       WHERE section_id IN
             (SELECT section_id
              FROM sections
              WHERE section_id = 95));

-- oef 4
SELECT student_id,first_name,last_name
FROM students
WHERE zip IN (SELECT zip
              FROM zipcodes
              WHERE UPPER(state) ='CT')
  AND student_id NOT IN (SELECT student_id
                         FROM enrollments)
ORDER BY 3,2;

-- oef 5

-- oef 6

-- oef 7
