--- Ejercicio 1 ---
SELECT
    emp.first_name,
    emp.last_name,
    dep.department_id,
    dep.department_name
FROM
    employees emp,
    departments dep
WHERE
    emp.department_id = dep.department_id;
    
--- Ejercicio 2 ---
SELECT
    emp.first_name,
    emp.last_name,
    dep.department_id,
    loc.city,
    loc.state_province
FROM
    employees emp
    JOIN departments dep ON emp.department_id = dep.department_id
    JOIN locations loc ON dep.location_id = loc.location_id;
    
--- Ejercicio 3 ---
SELECT
    emp.first_name,
    emp.last_name,
    emp.salary,
    j.job_title
FROM
    employees emp
    JOIN jobs j ON emp.job_id = j.job_id;

--- Ejercicio 4 ---
SELECT
    emp.first_name,
    emp.last_name,
    emp.department_id,
    dep.department_name
FROM
    employees emp
    JOIN departments dep ON dep.department_id = emp.department_id
WHERE
    dep.department_id = 80 OR dep.department_id = 40;

--- Ejercicio 5 ---
SELECT
    emp.first_name,
    emp.last_name,
    dep.department_name,
    loc.city,
    loc.state_province
FROM
    employees emp
    JOIN departments dep ON emp.department_id = dep.department_id
    JOIN locations loc ON loc.location_id = dep.location_id
WHERE
    emp.first_name LIKE '%z%';

--- Ejercicio 6 ---
SELECT
    emp.first_name,
    emp.last_name,
    dep.department_id,
    dep.department_name
FROM
    departments dep
    LEFT JOIN employees emp ON dep.department_id = emp.department_id; 

--- Ejercicio 7 ---
SELECT
    emp.first_name,
    emp.last_name,
    emp.salary
FROM
    employees emp
WHERE
    emp.salary < (
        SELECT
            salary
        FROM
            employees emp
        WHERE
            emp.employee_id = 182
    );

--- Ejercicio 8 ---
SELECT
    emp.first_name as employee_first_name,
    mgr.first_name as manager_first_name
FROM
    employees emp
    JOIN employees mgr ON emp.manager_id = mgr.employee_id;

--- Ejercicio 9 ---
SELECT
    dep.department_name,
    loc.city,
    loc.state_province
FROM
    departments dep
    JOIN locations loc ON loc.location_id = dep.location_id;

--- Ejercicio 10 ---
SELECT
    emp.first_name,
    emp.last_name,
    dep.department_id,
    dep.department_name
FROM
    employees emp
    LEFT JOIN departments dep ON emp.department_id = dep.department_id;

--- Ejercicio 11 ---
SELECT
    emp.first_name as employee_first_name,
    mgr.first_name as manager_first_name
FROM
    employees emp
    LEFT JOIN employees mgr ON emp.manager_id = mgr.employee_id;

--- Ejercicio 12 ---
SELECT
    emp.first_name,
    emp.last_name,
    emp.department_id
FROM
    employees emp
WHERE
    emp.department_id IN (
        SELECT
            emp.department_id
        FROM
            employees emp
        WHERE
            emp.last_name = 'Taylor'
    );

--- Ejercicio 13 ---
SELECT
    emp.first_name,
    dep.department_name,
    j.job_title,
    jh.start_date
FROM
    employees emp
    JOIN job_history jh ON emp.employee_id = jh.employee_id
    JOIN departments dep ON emp.department_id = dep.department_id
    JOIN jobs j ON emp.job_id = j.job_id
WHERE
    jh.start_date >= '04-APR-1993' AND jh.start_date <= '31-JUL-1997';

--- Ejercicio 14 ---
SELECT
    j.job_title,
    emp.first_name,
    j.max_salary - emp.salary as diferencia_salarial
FROM
    employees emp
    JOIN jobs j ON emp.job_id = j.job_id;

--- Ejercicio 15 ---
SELECT
    dep.department_name,
    AVG(emp.salary),
    COUNT(*)
FROM
    employees emp
    JOIN departments dep ON emp.department_id = dep.department_id
GROUP BY
    dep.department_name;

--- Ejercicio 16 ---
SELECT
    j.job_title,
    emp.first_name,
    (SELECT MAX(emp.salary) FROM employees emp) - emp.salary    
FROM
    employees emp
    JOIN departments dep ON emp.department_id = dep.department_id
    JOIN jobs j ON emp.job_id = j.job_id
WHERE
    emp.department_id = 80;

--- Ejercicio 17 ---
SELECT
    c.country_name,
    loc.city,
    dep.department_name    
FROM
    locations loc
    JOIN countries c ON loc.country_id = c.country_id
    JOIN departments dep ON dep.location_id = loc.location_id;

--- Ejercicio 18 ---
SELECT
    dep.department_name,
    mng.first_name,
    mng.last_name
FROM
    departments dep
    JOIN employees mng ON dep.manager_id = mng.employee_id;

--- Ejercicio 19 ---
SELECT
    j.job_title,
    AVG(emp.salary)
FROM
    employees emp
    JOIN jobs j ON emp.job_id = j.job_id
GROUP BY
    j.job_title;
    
--- Ejercicio 20 ---
SELECT
    emp.employee_id,
    jh.start_date,
    jh.end_date,
    emp.job_id,
    emp.department_id
FROM
    employees emp
    JOIN job_history jh ON emp.employee_id = jh.employee_id
WHERE
    emp.salary > 12000;
    
--- Ejercicio 21 ---
SELECT
    c.country_name,
    loc.city,
    COUNT(*) as empleados
FROM
    locations loc
    JOIN countries c ON loc.country_id = c.country_id
    JOIN departments dep ON dep.location_id = loc.location_id
    JOIN employees emp ON emp.department_id = dep.department_id
GROUP BY
    c.country_name, loc.city
HAVING
    COUNT(*) >= 2;

--- Ejerccio 22 ---
SELECT
    dep.department_name,
    mng.first_name as manager_first_name,
    mng.last_name as manager_las_name,
    loc.city
FROM
    employees mng
    JOIN departments dep ON mng.department_id = dep.department_id
    JOIN locations loc ON loc.location_id = dep.location_id;

--- Ejercicio 23 ---
SELECT
    emp.employee_id,
    j.job_title,
    jh.end_date - jh.start_date as dias_trabajados
FROM
    employees emp
    JOIN job_history jh ON emp.job_id = jh.job_id
    JOIN jobs j ON j.job_id = jh.job_id
WHERE
    emp.department_id = 80;

--- Ejercicio 24 ---
SELECT
    emp.first_name,
    emp.last_name,
    emp.salary
FROM
    employees emp
    JOIN departments dep ON emp.department_id = dep.department_id
    JOIN locations loc ON dep.location_id = loc.location_id
WHERE
    loc.city = 'London';
    
--- Ejercicios 25 ---
SELECT
    emp.first_name,
    emp.last_name,
    j.job_title,
    jh.start_date,
    jh.end_date    
FROM
    employees emp
    JOIN jobs j ON emp.job_id = j.job_id
    JOIN job_history jh ON emp.employee_id = jh.employee_id 
WHERE
    emp.commission_pct IS NULL;
    
--- Ejercicio 26 ---
SELECT
    dep.department_name,
    dep.department_id,
    COUNT(*) as empleados
FROM
    departments dep
    JOIN employees emp ON dep.department_id = emp.department_id
GROUP BY
    dep.department_name,
    dep.department_id
ORDER BY
    COUNT(*);

--- Ejercicio 27 ---
SELECT
    emp.first_name,
    emp.last_name,
    emp.employee_id,
    c.country_name
FROM
    employees emp
    JOIN departments dep ON emp.department_id = dep.department_id
    JOIN locations loc ON dep.location_id = loc.location_id
    JOIN countries c ON loc.country_id = c.country_id;
