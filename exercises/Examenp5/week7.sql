/*DROP TABLE zipcodes CASCADE;
DROP TABLE students CASCADE;
DROP TABLE instructors CASCADE;
DROP TABLE enrollments CASCADE;
DROP TABLE sections CASCADE;
DROP TABLE courses CASCADE;
DROP TABLE grade_conversions CASCADE;
DROP TABLE grade_type_weights CASCADE;
DROP TABLE grade_types CASCADE;
DROP TABLE grades CASCADE;*/

-- oef 1
CREATE TABLE IF NOT EXISTS students
(
    student_id        numeric(8, 0)
        CONSTRAINT pk_student_id PRIMARY KEY,
    salutation        varchar(5),
    first_name        varchar(25),
    last_name         varchar(25)
        CONSTRAINT c_last_name CHECK ( last_name = upper(last_name) ),
    street_address    varchar(50),
    zip               varchar(5),
    phone             varchar(15),
    employer          varchar(50),
    registration_date date,
    created_by        varchar(30)
        CONSTRAINT nn_created_by NOT NULL,
    created_date      date,
    modified_by       varchar(30),
    modified_date     date
);

CREATE TABLE IF NOT EXISTS zipcodes
(
    city          varchar(25),
    state         varchar(2),
    created_by    varchar(30),
    created_date  date,
    modified_by   varchar(30),
    modified_date date,
    zip           varchar(5)
        CONSTRAINT pk_zip PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS courses
(
    description   varchar(50),
    cost          numeric(9, 2),
    prerequisite  numeric(8),
    created_by    varchar(30),
    created_date  date,
    modified_by   varchar(30),
    modified_date date,
    course_no numeric(8)
);
