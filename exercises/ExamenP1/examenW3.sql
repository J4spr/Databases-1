-- oef 1 SA
SELECT city, state as "state"
FROM zipcodes
WHERE zip < '05000'
   OR upper(state) LIKE 'WV';

-- oef 2 SA
SELECT rpad(city, 20, '.')
FROM zipcodes
WHERE upper(state) = 'CT'
  AND substr(upper(city), 1, 1) BETWEEN 'A' and 'M';

-- oef 3 SA
SELECT last_name, position('a' in last_name) as "Letter a"
FROM students
WHERE position('a' in last_name) > 8;

-- oef 4 SA
SELECT student_id,
       last_name,
       created_date,
       concat((current_date - created_date), ' dagen geleden') as created_date
FROM students
WHERE student_id < 106;

-- oef 5 SA
SELECT DISTINCT section_id
FROM enrollments
WHERE enroll_date BETWEEN '2021-10-01' AND '2021-10-31';

-- oef 6 SA
SELECT cost, cost * 1.5 as "kost + 50%", round(cost * 1.5) as "kost + 50% met afronding"
from courses
order by cost;

-- oef 7 SA
SELECT last_name,
       registration_date,
       to_char(registration_date, 'DD-MM-YYYY') as "REG.DATE",
       to_char(registration_date, 'dy')         as day
FROM students;

-- oef 8 SA
SELECT concat_ws(' ', substr(first_name, 1, 1), last_name)
FROM students
WHERE lower(last_name) LIKE 'e%'
ORDER BY first_name
OFFSET 3;

-- oef 9 SA
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE first_name LIKE '%.%'
  AND salutation = 'Ms.'
ORDER BY length(last_name);

-- oef 10 SA
SELECT student_id, first_name as voornaam, last_name as achternaam, zip
FROM students
WHERE (upper(first_name) LIKE '%Y%' AND to_number(zip, '99999') = 10025)
   OR (upper(left(last_name, 1)) BETWEEN 'W' AND 'Z');

-- oef 11 SA
SELECT description, prerequisite
FROM courses
WHERE lower(description) LIKE 'intro to%'
  AND prerequisite IS NULL;

-- oef 12 SA
SELECT length('Ik tel zoveel letters in totaal') totaal

-- oef 13 SA
SELECT student_id, salutation, first_name, last_name
FROM students
WHERE salutation = 'Ms.'
  AND (lower(last_name) = 'allende' OR lower(last_name) = 'grant')
ORDER BY length(last_name);

-- oef 14 SA
SELECT last_name, first_name
FROM instructors
where position('o' in last_name) = 2;

-- oef 15 SA
SELECT concat('Vandaag is het ', to_char(current_date, 'DD/MM/YYYY'));

-- oef 16 SA
SELECT CONCAT('vandaag is het ', RPAD(TO_CHAR(current_date, 'FMDay'), 10, '*'),
              ' de ', TO_CHAR(current_date, 'ddTH')) "Welke dag zijn we?";

-- oef 17 SA
SELECT course_no, replace(description, 'Java', 'C#')
FROM courses
WHERE upper(description) LIKE '%JAVA%'
ORDER BY course_no;

-- oef 18 SA
SELECT student_id, section_id, grade_type_code, round(numeric_grade / 5) as numeric_grade_op_20
FROM grades
WHERE upper(grade_type_code) LIKE 'PA%';

-- oef 19 SA
SELECT extract(Month from age(current_date, '01/09/2025')) as "maanden al bezig";

-- oef 20 SA
-- a)
SELECT student_id, section_id, to_char(enroll_date, 'DD month YYYY') FROM enrollments WHERE section_id = 117;

-- b)
SELECT student_id,section_id,'The '||TO_CHAR(enroll_date,'ddth')||' in the '
|| TO_CHAR(enroll_date,'wwth') ||' week of the year '
|| TO_CHAR(enroll_date,'yyyy')inschrijvingsdatum
FROM enrollments
WHERE section_id=117;
