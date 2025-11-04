SELECT employee_id, sum(hours)
FROM tasks
GROUP BY employee_id ;


-- oef 2
SELECT hours
FROM tasks
WHERE employee_id='999444444';

SELECT COUNT(hours)
FROM tasks
WHERE employee_id='999444444';


SELECT SUM(hours)
FROM tasks
WHERE employee_id='999444444';

