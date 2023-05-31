DECLARE
    L_EMPNO NUMBER;
    L_JOB VARCHAR2(200);
    L_MGR NUMBER;
    L_SAL NUMBER;
    L_COMM NUMBER;
    L_DEPTNO NUMBER;
    L_SALARYCHANGE NUMBER;
    
BEGIN
    L_EMPNO := 101;
    L_JOB := 'SA_MAN';
    L_MGR := 100;
    L_SAL := 25000;
    L_COMM := 0.3;
    L_DEPTNO := 80;

    PROMOTE(
        L_EMPNO => L_EMPNO,
        L_JOB => L_JOB,
        L_MGR => L_MGR,
        L_SAL => L_SAL,
        L_COMM => L_COMM,
        L_DEPTNO => L_DEPTNO,
        L_SALARYCHANGE => L_SALARYCHANGE
    );

    DBMS_OUTPUT.PUT_LINE('L_SALARYCHANGE = ' || L_SALARYCHANGE);

    :L_SALARYCHANGE := L_SALARYCHANGE;
--rollback; 
END;

select * from employees where employee_id=100;