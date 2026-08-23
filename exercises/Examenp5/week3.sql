--03 - Exercises functions - DB Student administration

--Exercise 1
SELECT city, INITCAP(lower(state)) state
FROM zipcodes
WHERE (to_number(zip, '99999') < 5000) OR (upper(state) = 'WV')
ORDER BY state, city;

--Exercise 2
SELECT RPAD(city,20,'.') "CITY"
FROM zipcodes
WHERE UPPER(state) = 'CT' and SUBSTR(UPPER(city) ,1,1) BETWEEN 'A' AND 'M';

--Exercise 3
SELECT last_name, position('a' in last_name) " Letter a"
FROM students
WHERE position('a' in last_name)>8;

--Exercise 4
SELECT student_id, last_name, created_date, ((current_date - created_date))
    || ' dagen geleden ' as "created_date"
FROM students
WHERE student_id < 106;

--Exercise 5
SELECT DISTINCT section_id
FROM enrollments
WHERE enroll_date between '2021-10-01' AND '2021-10-31';

--Exercise 6
SELECT DISTINCT cost, cost *1.5 "kost + 50%", ROUND(cost*1.5)
                                "Kost + 50 met afronding"
FROM COURSES
WHERE cost Is NOT NULL;

--Exercise 7
SELECT last_name, registration_date,
       TO_CHAR(registration_date,'dd-mm-YYYY') "REG.DATE",
       TO_CHAR(registration_date, 'dy') "day"
FROM students
WHERE student_id IN (123, 161, 190);

--Exercise 8
SELECT LEFT(initcap(first_name),1)|| ' ' ||
       last_name "Naam"
FROM students
WHERE UPPER( last_name) LIKE 'E%'
ORDER BY last_name;

--Exercise 9
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE first_name LIKE '%.%' AND salutation = 'Ms.'
ORDER BY LENGTH(last_name);

--Exercise 10
SELECT student_id, first_name voornaam, last_name
                              achternaam, zip
FROM students
WHERE (UPPER(first_name) LIKE '%Y%' AND to_number(zip, '99999') = 10025) OR
    (UPPER(LEFT(last_name,1)) BETWEEN 'W' AND 'Z');

--Exercise 11
SELECT description, prerequisite
FROM COURSES
WHERE UPPER(description) LIKE 'INTRO TO%' AND prerequisite IS
    NULL;

--Exercise 12
SELECT LENGTH('Ik tel zoveel letters in totaal') "Totaal"

--Exercise 13
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE salutation = 'Ms.' AND UPPER(last_name) IN ('ALLENDE',
                                                  'GRANT')
ORDER BY LENGTH(last_name);

--Exercise 14
SELECT last_name "LAST NAME", first_name "FIRST NAME"
FROM instructors
WHERE POSITION('o' in last_name) =2

--Exercise 15
SELECT CONCAT( 'vandaag is het ',RPAD(to_char(current_date, 'DD/MM/YYYY'),14,'*')) "Welke dag
zijn we?"

--Exercise 16
SELECT CONCAT( 'vandaag is het ',RPAD(TO_CHAR(current_date, 'FMDay'),10,'*'),
               ' de ', TO_CHAR(current_date,'ddTH')) "Welke dag zijn
we?"

--Exercise 17
SELECT course_no,REPLACE(description,'Java','C#') description
FROM courses
WHERE UPPER(description) like '%JAVA%'
ORDER BY course_no;


--Exercise 18
SELECT
    student_id,section_id,grade_type_code,ROUND(numeric_grade/5)
    numeric_grade_op_20
FROM grades
WHERE grade_type_code='PA';

--Exercise 19
SELECT EXTRACT(Month FROM age(current_date,'01/09/2021')) as "maanden al bezig"

--Exercise 20
SELECT section_id,RPAD(TO_CHAR(start_date_time, 'DD/MM/YYYY'), 12, ' ') || ' ' || TO_CHAR(start_date_time,'TMday') start_date_time
FROM sections
WHERE section_id BETWEEN 80 AND 89
ORDER BY 1;

--Exercise 21a
SELECT student_id,section_id,TO_CHAR(enroll_date,'dd month yyyy') inschrijvingsdatum
FROM enrollments
WHERE section_id=117;

--Exercise 21b
SELECT student_id,section_id,'The '||TO_CHAR(enroll_date,'ddth')||' in the '
                                 || TO_CHAR(enroll_date,'wwth') ||' week of the year '
    || TO_CHAR(enroll_date,'yyyy')inschrijvingsdatum
FROM enrollments
WHERE section_id=117;