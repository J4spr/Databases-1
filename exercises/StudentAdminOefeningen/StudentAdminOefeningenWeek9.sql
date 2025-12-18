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
WHERE course_no IN (
    SELECT course_no
    FROM sections
    WHERE instructor_id IN (
        SELECT instructor_id
        FROM instructors
        WHERE lower(concat_ws(' ', first_name, last_name)) = 'fernand hanks'));
