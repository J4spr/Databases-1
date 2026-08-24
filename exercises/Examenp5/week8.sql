-- oef 1
ALTER TABLE grades
    ALTER COLUMN numeric_grade SET DEFAULT 0;

-- oef 2
ALTER TABLE grade_conversions
    ALTER COLUMN grade_point SET DEFAULT 0;

-- oef 3
ALTER TABLE enrollments
    ADD CONSTRAINT ch_final_grade CHECK ( final_grade BETWEEN 0 AND 100 ) NOT VALID;
UPDATE enrollments
SET final_grade = 0
WHERE final_grade NOT BETWEEN 0 AND 100;
SELECT final_grade
FROM enrollments;

ALTER TABLE courses
    ADD CONSTRAINT ch_cost check ( cost < 2000 );


-- oef 4
ALTER TABLE instructors
    ADD CONSTRAINT ch_salutation CHECK ( salutation IN ('Rev', 'Ms.', 'Dr.', 'Mr.', NULL) );
ALTER TABLE students
    ADD CONSTRAINT ch_salutation CHECK ( salutation IN ('Rev', 'Ms.', 'Dr.', 'Mr.', NULL) );
INSERT INTO instructors
VALUES (0,
        'Mr.',
        'jasper',
        'verbruggen',
        'Bierbeekstraat',
        (SELECT zip FROM zipcodes WHERE state = 'MA' LIMIT 1),
        '+32474193486',
        'jasper',
        CURRENT_DATE,
        'jasper',
        CURRENT_DATE);


-- oef 5
ALTER TABLE sections
    ADD CONSTRAINT ch_capacity CHECK ( capacity BETWEEN 10 AND 25);

-- oef 6
ALTER TABLE students
    ADD COLUMN email varchar(30);
SELECT email
FROM students;

-- oef 7
ALTER TABLE sections
    DROP CONSTRAINT sect_inst_fk;
ALTER TABLE sections
    ADD CONSTRAINT sect_inst_fk FOREIGN KEY (instructor_id) REFERENCES instructors ON DELETE SET NULL;
\

-- oef 8
ALTER TABLE enrollments
    DROP CONSTRAINT enr_stu_fk;
ALTER TABLE students
    ADD CONSTRAINT enr_stu_fk FOREIGN KEY (student_id) REFERENCES students (student_id) ON DELETE CASCADE;
DELETE
FROM students
where student_id = 139;
SELECT *
FROM enrollments e
         JOIN students s ON e.student_id = s.student_id
JOIN grades g ON g.student_id = s.student_id WHERE e.student_id = 139;

-- oef 9
-- ALTER TABLE grade_type_weights RENAME COLUMN percent_of_final_grade TO percent_of_final

-- oef 10
