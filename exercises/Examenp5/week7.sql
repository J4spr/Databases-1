set search_path = "public";
DROP TABLE zipcodes CASCADE;
DROP TABLE students CASCADE;
DROP TABLE instructors CASCADE;
DROP TABLE enrollments CASCADE;
DROP TABLE sections CASCADE;
DROP TABLE courses CASCADE;
DROP TABLE grade_conversions CASCADE;
DROP TABLE grade_type_weights CASCADE;
DROP TABLE grade_types CASCADE;
DROP TABLE grades CASCADE;
-- oef 1
CREATE TABLE IF NOT EXISTS students
(
    student_id        numeric(8, 0)
        CONSTRAINT pk_student_id PRIMARY KEY,
    salutation        varchar(5),
    first_name        varchar(25),
    last_name         varchar(25)
        CONSTRAINT ch_last_name CHECK ( last_name = upper(last_name) ),
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
    course_no     numeric(8)
);


CREATE TABLE IF NOT EXISTS sections
(
    course_no       numeric(8),
    section_no      numeric(3),
    start_date_time date,
    location        varchar(50),
    instructor_id   numeric(8),
    capacity        numeric(3),
    created_by      varchar(30),
    modified_by     varchar(30),
    modified_date   date,
    section_id      numeric(8)
        CONSTRAINT pk_section_id PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS enrollments
(
    enroll_date   date,
    final_grade   numeric(3),
    created_by    varchar(30),
    created_date  date,
    modified_by   varchar(30),
    modified_date date,
    section_id    numeric(8)
);

CREATE TABLE IF NOT EXISTS instructors
(
    salutation     varchar(5),
    first_name     varchar(25),
    last_name      varchar(25),
    street_address varchar(50),
    zip            varchar(5),
    phone          varchar(15),
    created_by     varchar(30),
    created_date   date,
    modified_by    varchar(30),
    modified_date  date,
    instructor_id  numeric(8)
        CONSTRAINT pk_instructor_id PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS grades
(
    numeric_grade        numeric(3),
    comments             varchar(2000),
    created_by           varchar(30),
    created_date         date,
    modified_by          varchar(30),
    modified_date        date,
    student_id           numeric(8),
    section_id           numeric(8),
    grade_type_code      char(2),
    grade_type_occurence numeric(8)
);

CREATE TABLE IF NOT EXISTS grade_types
(
    description     varchar(50),
    created_by      varchar(30),
    created_date    date,
    modified_by     varchar(30),
    modified_date   date,
    grade_type_code char(2)
        CONSTRAINT pk_grade_type_code PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS grade_type_weights
(
    number_per_section     numeric(3),
    percent_of_final_grade numeric(3),
    drop_lowest            char,
    created_by             varchar(30),
    created_date           date,
    modified_by            varchar(30),
    modified_date          date,
    section_id             numeric(8),
    grade_type_code        char(2)
        CONSTRAINT pk_grade_type_codes PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS grade_conversions
(
    grade_point   numeric(3, 2),
    max_grade     numeric(3),
    min_grade     numeric(3),
    created_by    varchar(30),
    created_date  date,
    modified_by   varchar(30),
    modified_date date,
    letter_grade  char
        CONSTRAINT pk_letter_grade PRIMARY KEY
);

-- checks
ALTER TABLE students
    ADD CONSTRAINT un_student_id UNIQUE (student_id);
ALTER TABLE students
    ADD CONSTRAINT ch_registration_date check ( registration_date = current_date );


-- foreign keys
ALTER TABLE students
    ADD CONSTRAINT fk_zipcodes FOREIGN KEY (zip) REFERENCES zipcodes (zip);
/*ALTER TABLE courses
    ADD CONSTRAINT fk_prerequisite FOREIGN KEY (prerequisite) REFERENCES courses (course_no);
ALTER TABLE enrollments
    ADD CONSTRAINT fk_section_id FOREIGN KEY (section_id) REFERENCES enrollments (section_id);
*/