-- AGREGAR EMPLEADO ------------------------------------------------------------
DECLARE
    v_first_name     employees.first_name%TYPE := 'TOMAS';
    v_last_name      employees.last_name%TYPE := 'GRIFFA';
    v_email          employees.email%TYPE := 'tgriffa';
    v_phone_number   employees.phone_number%TYPE := '111.111.1111';
    v_hire_date      employees.hire_date%TYPE := TO_DATE ( '15-May-23', 'DD-MON-YY' );
    v_job_id         employees.job_id%TYPE := 'IT_PROG';
    v_salary         employees.salary%TYPE := 15000;
    v_commission_pct employees.commission_pct%TYPE := 0.2;
    v_manager_id     employees.manager_id%TYPE := 112;
    v_department_id  employees.department_id%TYPE := 60;
    v_error_msg      VARCHAR2(200);
    v_result         BOOLEAN;
BEGIN
    -- Llamo a la funcion agregar_empleado()
    v_result := pa_gestion_hr.agregar_empleado(v_first_name, v_last_name, v_email, v_phone_number, v_hire_date,
                                              v_job_id, v_salary, v_commission_pct, v_manager_id, v_department_id,
                                              v_error_msg);

    IF v_result THEN
        dbms_output.put_line('El empleado ha sido agregado exitosamente.');
    ELSE
        dbms_output.put_line('Error al agregar el empleado: ' || v_error_msg);
    END IF;

END;

-- ELIMINAR EMPLEADO -----------------------------------------------------------
DECLARE
    v_employee_id employees.employee_id%TYPE := 209;
    v_error_msg   VARCHAR2(200);
    v_result      BOOLEAN;
BEGIN
    -- Llamo a la función eliminar_empleado()
    v_result := pa_gestion_hr.eliminar_empleado(v_employee_id, v_error_msg);
    IF v_result THEN
        dbms_output.put_line('El empleado ha sido eliminado exitosamente.');
    ELSE
        dbms_output.put_line('Error al eliminar el empleado: ' || v_error_msg);
    END IF;

END;

-- MODIFICAR EMPLEADO ----------------------------------------------------------
DECLARE
    v_employee_id    employees.employee_id%TYPE := 999;
    v_first_name     employees.first_name%TYPE := 'modificado';
    v_last_name      employees.last_name%TYPE := 'modificado';
    v_email          employees.email%TYPE := 'modificado';
    v_phone_number   employees.phone_number%TYPE := '111.111.1111';
    v_hire_date      employees.hire_date%TYPE := TO_DATE ( '15-May-23', 'DD-MON-YY' );
    v_job_id         employees.job_id%TYPE := 'IT_PROG';
    v_salary         employees.salary%TYPE := 7777;
    v_commission_pct employees.commission_pct%TYPE := NULL;
    v_manager_id     employees.manager_id%TYPE := 112;
    v_department_id  employees.department_id%TYPE := 60;
    v_error_msg      VARCHAR2(200);
    v_result         BOOLEAN;
BEGIN
    -- Llamo a la funcion modificar_empleado()
    v_result := pa_gestion_hr.modificar_empleado(v_employee_id, v_first_name, v_last_name, v_email, v_phone_number,
                                                v_hire_date, v_job_id, v_salary, v_commission_pct, v_manager_id,
                                                v_department_id, v_error_msg);

    IF v_result THEN
        dbms_output.put_line('El empleado ha sido modificado exitosamente.');
    ELSE
        dbms_output.put_line('Error al modificar el empleado: ' || v_error_msg);
    END IF;

END;

-- AGREGAR JOB ----------------------------------------------------------------
DECLARE
    v_job_id     jobs.job_id%TYPE := 'PRUE';
    v_job_title  jobs.job_title%TYPE := 'HOLAHOLA';
    v_min_salary jobs.min_salary%TYPE := 1;
    v_max_salary jobs.max_salary%TYPE := 10000;
    v_error_msg  VARCHAR2(200);
    v_result     BOOLEAN;
BEGIN
    v_result := pa_gestion_hr.agregar_puesto(v_job_id, v_job_title, v_min_salary, v_max_salary, v_error_msg);
    IF v_result THEN
        dbms_output.put_line('El puesto ha sido agregado exitosamente.');
    ELSE
        dbms_output.put_line('Error al agregar el puesto: ' || v_error_msg);
    END IF;

END;

-- ELIMINAR JOB ---------------------------------------------------------------
DECLARE
    v_job_id    jobs.job_id%TYPE := 'IT_PROG';
    v_error_msg VARCHAR2(200);
    v_result    BOOLEAN;
BEGIN
    v_result := pa_gestion_hr.eliminar_puesto(v_job_id, v_error_msg);
    IF v_result THEN
        dbms_output.put_line('El puesto ha sido eliminado exitosamente.');
    ELSE
        dbms_output.put_line('Error al eliminar el puesto: ' || v_error_msg);
    END IF;

END;

-- MODIFICAR JOB
DECLARE
    v_job_id     jobs.job_id%TYPE := 'PRUE';
    v_job_title  jobs.job_title%TYPE := 'HOLAHOLA';
    v_min_salary jobs.min_salary%TYPE := 1;
    v_max_salary jobs.max_salary%TYPE := 10000;
    v_error_msg  VARCHAR2(200);
    v_result     BOOLEAN;
BEGIN
    v_result := pa_gestion_hr.agregar_puesto(v_job_id, v_job_title, v_min_salary, v_max_salary, v_error_msg);
    IF v_result THEN
        dbms_output.put_line('El puesto ha sido agregado exitosamente.');
    ELSE
        dbms_output.put_line('Error al agregar el puesto: ' || v_error_msg);
    END IF;

END;