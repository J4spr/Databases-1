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
FROM sections
WHERE course_no IN (
    SELECT *
    FROM courses
    WHERE (
        SELECT instructor_id, first_name, last_name
        FROM instructors
        WHERE lower(concat_ws(' ', first_name, last_name)) = 'fernand hanks'));
