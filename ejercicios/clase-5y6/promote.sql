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
