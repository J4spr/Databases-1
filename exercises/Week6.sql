-- CONVENTIE: <prefix>_<tabelnaam>_<optioneel_kolomnaam>
-- PRIMARY KEY - prefix pk, geen kolom
-- CHECK - prefix ch
-- FOREIGN KEY - fk
-- UNIQUE - un

DROP TABLE IF EXISTS students;
CREATE TABLE IF NOT EXISTS students
(
    student_id CHAR(10)     NOT NULL
        CONSTRAINT pk_students PRIMARY KEY,
    name       varchar(50)  NOT NULL,
    street     VARCHAR(100) NOT NULL,
    nr         NUMERIC(4)   NOT NULL
        CONSTRAINT ch_students_nr CHECK ( nr > 0),
    postalcode NUMERIC(30)  NOT NULL
        CONSTRAINT ch_students_postal_code CHECK ( postalcode BETWEEN 1000 AND 9999),
    city       VARCHAR(30)  NOT NULL,
    birth_date DATE         NOT NULL
        CONSTRAINT ch_students_birth_date
            CHECK ( birth_date > CURRENT_DATE )
);

DROP TABLE IF EXISTS classes;
CREATE TABLE classes
(
    class_id   NUMERIC(4) NOT NULL PRIMARY KEY,
    building   CHAR(2)    NOT NULL
        CONSTRAINT ch_classes_building CHECK ( building IN ('GR', 'PH', 'SW') ),
    floor      NUMERIC(1) NOT NULL
        CONSTRAINT ch_classes_floor CHECK ( floor BETWEEN 1 AND 5),
    roomnumber NUMERIC(2) NOT NULL
        CONSTRAINT ch_classes_roomnumber CHECK ( roomnumber > 0 )
);

-- oef 5 + 6
DROP TABLE IF EXISTS student_classes;
CREATE TABLE student_classes
(
    studentnumber CHAR(10)
        CONSTRAINT fk_students_classes_studentnumber
            REFERENCES students (student_id),
    classnumber   NUMERIC(4)
        CONSTRAINT fk_student_classes_classnumber
            REFERENCES classes (class_id),

    CONSTRAINT pk_student_classes PRIMARY KEY (studentnumber, classnumber)
);

DROP TABLE IF EXISTS employees;
CREATE TABLE IF NOT EXISTS employees(

);

CREATE TABLE IF NOT EXISTS family_members
(
    employee_id CHAR(9)
);
-- verwijst naar de tabel EMPLOYEES
-- . name Variabele lengte, max 50 tekens
-- . gender Variabele lengte, max 50 tekens – moet ingevuld zijn
-- . birth_date Alleen geboortedatums tussen March 20, 1950 en
--
-- January 1, 2018 zijn toegelaten
--
-- . relationship Max 10 karakters
--
-- Alle attributen in deze table MOETEN een geldige waarde krijgen, behalve de
-- birth_date
-- Primary Key: employee_id + name

INSERT INTO students
(student_id, name, street, nr, postalcode, city, birth_date)
VALUES
    ('100', 'Albert Einstein', 'Mercer Street', 112, 8540, '
Princeton, New Jersey', '1879-03-14');
INSERT INTO classes (class_id, building, floor, roomnumber)
VALUES (1, 'GR', '1', 13);
INSERT INTO student_classes (studentnumber, classnumber)
VALUES (100, 1);

