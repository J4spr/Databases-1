-- oef 1
ALTER TABLE grades
    ALTER COLUMN numeric_grade SET DEFAULT 0;
-- oef 2
ALTER TABLE grade_conversions
    ALTER COLUMN grade_point SET DEFAULT 0;

-- oef 3
-- a)
ALTER TABLE enrollments
    ADD CONSTRAINT ch_enrollments_final_grade
        check ( final_grade BETWEEN 0 AND 100);

-- b)
UPDATE enrollments
set final_grade = 100
WHERE final_grade NOT BETWEEN 0 AND 100

-- c)
ALTER TABLE enrollments VALIDATE CONSTRAINT ch_enrollments_final_grade;

-- d)
ALTER TABLE courses
ADD CONSTRAINT ch_courses_cost
check ( cost < 2000 );


-- oef 4
ALTER TABLE students ADD CONSTRAINT ch_students_salutation
CHECK ( salutation IN ('Rev', 'Ms', 'Mr', 'Dr') );

-- oef 5
