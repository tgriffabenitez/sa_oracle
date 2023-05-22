# Ejercicios de la clase 1 y 2 - tgriffabenitez

## Ejercicio 1
Escriba una consulta SQL para encontrar el nombre, el apellido, el número de departamento y el nombre del departamento de cada empleado.  

```sql
SELECT
    emp.first_name,
    emp.last_name,
    dep.department_id,
    dep.department_name
FROM
    employees   emp,
    departments dep
WHERE
    emp.department_id = dep.department_id
```

## Ejercicio 2
Escriba una consulta SQL para encontrar el nombre, el apellido, el departamento, la ciudad y la provincia de cada empleado.  

```sql
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
```

## Ejercicio 3
Escribir una consulta SQL para encontrar el nombre, el apellido, el salario y la categoría laboral de todos los empleados.

```sql
SELECT
    emp.first_name,
    emp.last_name,
    emp.salary,
    j.job_title
FROM
    employees emp
    JOIN jobs j ON emp.job_id = j.job_id;
```

## Ejercicio 4
Escriba una consulta SQL para buscar todos los empleados que trabajan en el departamento ID=80 o el 40. Devuelva el nombre, el apellido, el número de departamento y el nombre del departamento

```sql
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
```

## Ejercicio 5
Escribir una consulta SQL para encontrar aquellos empleados cuyo primer nombre contenga la letra 'z'. Devuelve nombre, apellido, departamento, ciudad y estado provincia.

```sql
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
```

## Ejercicio 6
Escriba una consulta SQL para buscar todos los departamentos, incluidos los que no tienen empleados. Devuelva el nombre, el apellido, el ID del departamento, el nombre del departamento.

Obervacion: Hice un `LEFT JOIN` porque la tabla _departamentos_ "es mas grande" y esta a la izquierda de la tabla _empleados_.

```sql
SELECT
    emp.first_name,
    emp.last_name,
    dep.department_id,
    dep.department_name
FROM
    departments dep
    LEFT JOIN employees emp ON emp.department_id = dep.department_id; 
```

## Ejercicio 7
Escriba una consulta SQL para encontrar los empleados que ganan menos que el empleado de ID 182. Devuelva el nombre, apellido y salario
```sql
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
```

## Ejercicio 8
Escriba una consulta SQL para encontrar a los empleados y sus gerentes. Devuelva el nombre del empleado y del gerente.  

```sql
SELECT
    emp.first_name as employee_first_name,
    mgr.first_name as manager_first_name
FROM
    employees emp
    JOIN employees mgr ON emp.manager_id = mgr.employee_id;
```

## Ejercicio 9
Escriba una consulta SQL para mostrar el nombre del departamento, la ciudad y la provincia del estado de cada departamento.  

```sql
SELECT
    dep.department_name,
    loc.city,
    loc.state_province
FROM
    departments dep
    JOIN locations loc ON loc.location_id = dep.location_id;
```

## Ejercicio 10
Escribir una consulta SQL para averiguar qué empleados tienen o no tienen un departamento. Devuelva el nombre, el apellido, el ID del departamento, el nombre del departamento.  

```sql
SELECT
    emp.first_name,
    emp.last_name,
    dep.department_id,
    dep.department_name
FROM
    employees emp
    LEFT JOIN departments dep ON emp.department_id = dep.department_id;
```

## Ejercicio 11
Escriba una consulta SQL para encontrar a los empleados y sus gerentes. Aquellos gerentes que no trabajan bajo ningún gerente también aparecen en la lista. Devuelva el nombre del empleado y del gerente. 

```sql
SELECT
    emp.first_name as employee_first_name,
    mgr.first_name as manager_first_name
FROM
    employees emp
    LEFT JOIN employees mgr ON emp.manager_id = mgr.employee_id;
```

## Ejercicio 12
Escribir una consulta SQL para encontrar los empleados que trabajan en el mismo departamento que el empleado con el apellido Taylor. Devuelva el nombre, el apellido y el ID del departamento.

Observacion: Uso la palabra clave `IN` ya que el resultado de la subquery devuelve dos valors de id (50 y 80). Es por eso que uso `IN` y no `=`

```sql
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
```

## Ejercicio 13
Escriba una consulta SQL para encontrar todos los empleados que se incorporaron el 04 de abril de 1993 o después y el 31 de julio de 1997 o antes. Devuelva el puesto, el nombre del departamento, el nombre del empleado y la fecha de incorporación al puesto.

```sql
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
```

## Ejercicio 14
Escribir una consulta SQL para calcular la diferencia entre el salario máximo del trabajo y el salario del empleado. Devuelve el cargo, el nombre del empleado y la diferencia salarial.

```sql
SELECT
    j.job_title,
    emp.first_name,
    j.max_salary - emp.salary as diferencia_salarial
FROM
    employees emp
    JOIN jobs j ON emp.job_id = j.job_id;

```

## Ejercicio 15
Escriba una consulta SQL para calcular el salario promedio, la cantidad de empleados que reciben comisiones en ese departamento. Nombre del departamento de devolución, salario promedio y número de empleados.  

```sql
SELECT
    dep.department_name,
    AVG(emp.salary),
    COUNT(*)
FROM
    employees emp
    JOIN departments dep ON emp.department_id = dep.department_id
GROUP BY
    dep.department_name
```

## Ejercicio 16
Escribir una consulta SQL para calcular la diferencia entre el salario máximo y el salario de todos los empleados que trabajan en el departamento de ID 80. Devuelva el cargo, el nombre del empleado y la diferencia de salario.

```sql
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
```
## Ejercicio 17
Escriba una consulta SQL para encontrar el nombre del país, la ciudad y los departamentos que se ejecutan allí.

```sql
SELECT
    c.country_name,
    loc.city,
    dep.department_name    
FROM
    locations loc
    JOIN countries c ON loc.country_id = c.country_id
    JOIN departments dep ON dep.location_id = loc.location_id;
```

## Ejercicio 18
Escribir una consulta SQL para encontrar el nombre del departamento y el nombre completo (nombre y apellido) del gerente. 

```sql
SELECT
    dep.department_name,
    mng.first_name,
    mng.last_name
FROM
    departments dep
    JOIN employees mng ON dep.manager_id = mng.employee_id;
```

## Ejercicio 19
Escriba una consulta SQL para calcular el salario promedio de los empleados para cada cargo.

```sql
SELECT
    j.job_title,
    AVG(emp.salary)
FROM
    employees emp
    JOIN jobs j ON emp.job_id = j.job_id
GROUP BY
    j.job_title;
```

## Ejercicio 20
De la siguiente tabla, escriba una consulta SQL para encontrar los empleados que ganan $12000 o más. Devuelva la identificación del empleado, la fecha de inicio, la fecha de finalización, la identificación del trabajo y la identificación del departamento.

```sql
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
```

## Ejercicio 21
A partir de las siguientes tablas, escriba una consulta SQL para averiguar qué departamentos tienen al menos dos empleados. Agrupe el conjunto de resultados por nombre de país y ciudad. Devuelve el nombre del país, la ciudad y el número. 

```sql
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
```

## Ejercicio 22
De las siguientes tablas, escriba una consulta SQL para encontrar el nombre del departamento, el nombre completo (nombre y apellido) del gerente y su ciudad.

```sql
SELECT
    dep.department_name,
    mng.first_name as manager_first_name,
    mng.last_name as manager_las_name,
    loc.city
FROM
    employees mng
    JOIN departments dep ON mng.department_id = dep.department_id
    JOIN locations loc ON loc.location_id = dep.location_id
```

## Ejercicio 23
A partir de las siguientes tablas, escriba una consulta SQL para calcular la cantidad de días trabajados por los empleados en un departamento de ID 80. Devuelva la ID del empleado, el cargo y la cantidad de días trabajados.  

```sql
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
```

## Ejercicio 24
A partir de las siguientes tablas, escriba una consulta SQL para encontrar el nombre completo (nombre y apellido) y el salario de todos los empleados que trabajan en cualquier departamento de la ciudad de Londres. 

```sql
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
```

## Ejercicio 25
De las siguientes tablas, escriba una consulta SQL para encontrar el nombre completo (nombre y apellido), cargo, fecha de inicio y finalización de los últimos trabajos de los empleados que no recibieron comisiones. 

```sql
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
    emp.commission_pct IS NULL
```

## Ejercicio 26
A partir de las siguientes tablas, escriba una consulta SQL para encontrar el nombre del departamento, el ID del departamento y la cantidad de empleados en cada departamento. 

```sql
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
```

## Ejercicio 27
A partir de las siguientes tablas, escriba una consulta SQL para averiguar el nombre completo (nombre y apellido) del empleado con identificación y el nombre del país donde trabaja actualmente. 

```sql
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
```