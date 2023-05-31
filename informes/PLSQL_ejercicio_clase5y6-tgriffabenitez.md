# Ejercicios de la clase 5 y 6 - tgriffabenitez

## Procedure `promote`
```sql
CREATE OR REPLACE PROCEDURE promote (
    l_empno        IN NUMBER,
    l_job          IN VARCHAR2,
    l_mgr          IN NUMBER,
    l_sal          IN NUMBER,
    l_comm         IN NUMBER,
    l_deptno       IN NUMBER,
    l_salarychange OUT NUMBER
) IS
    oldsalary NUMBER;
BEGIN
  
    SELECT
        nvl(e.salary, 0)
    INTO oldsalary
    FROM
        employees e
    WHERE
        e.employee_id = l_empno;

    UPDATE employees e
    SET
        e.job_id = nvl(l_job, e.job_id),
        e.manager_id = nvl(l_mgr, e.manager_id),
        e.salary = nvl(l_sal, e.salary),
        e.commission_pct = nvl(l_comm, e.commission_pct),
        e.department_id = nvl(l_deptno, e.department_id)
    WHERE
        e.employee_id = l_empno;

    l_salarychange := nvl(l_sal, oldsalary) - oldsalary;
END;
```
El procedure `promote` actualiza los detalles del empleado en la tabla `employees` con los valores proporcionados y calcula la diferencia en el cambio de salario, que se devuelve como parámetro de salida.

El procedimiento toma el número de id del empleado (l_empno) como entrada y busca en la tabla "employees" el salario actual del empleado correspondiente y lo almacena en la variable "oldsalary" utilizando la cláusula SELECT INTO.

Luego, actualiza la tabla `employees` con los valores proporcionados en los parámetros de entrada. Si un parámetro de entrada es nulo (null), se conserva el valor existente en la tabla. Los campos que se actualizan son: `job_id`, `manager_id`, `salary`, `commission_pct` y `department_id`. La cláusula WHERE se utiliza para especificar que se debe actualizar el registro del empleado con el número de id del empleado (l_empno) proporcionado.

Después de la actualización, se calcula la diferencia entre el nuevo salario proporcionado (l_sal) o el salario existente y el antiguo salario (oldsalary). Esta diferencia se asigna al parámetro de salida l_salarychange.

## Implementación
Primero se selecciono a la empleada con id = 146
![inicio](antes.png)

Luego, se modificaron algunos de los valores de la empleada con id = 146
![fin](despues.png)
## Servicio Rest
![imagen2](servicio_rest.png)