create or replace PACKAGE BODY pa_gestion_hr AS
-- AGREGAR EMPLEADO ------------------------------------------------------------
    FUNCTION agregar_empleado (
        p_first_name     IN employees.first_name%TYPE,
        p_last_name      IN employees.last_name%TYPE,
        p_email          IN employees.email%TYPE,
        p_phone_number   IN employees.phone_number%TYPE,
        p_hire_date      IN employees.hire_date%TYPE,
        p_job_id         IN employees.job_id%TYPE,
        p_salary         IN employees.salary%TYPE,
        p_commission_pct IN employees.commission_pct%TYPE,
        p_manager_id     IN employees.manager_id%TYPE,
        p_department_id  IN employees.department_id%TYPE,
        p_error_msg      OUT VARCHAR2
    ) RETURN BOOLEAN AS
    BEGIN
        INSERT INTO employees (
            first_name,
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            commission_pct,
            manager_id,
            department_id
        ) VALUES (
            p_first_name,
            p_last_name,
            p_email,
            p_phone_number,
            p_hire_date,
            p_job_id,
            p_salary,
            p_commission_pct,
            p_manager_id,
            p_department_id
        );

        COMMIT;
        p_error_msg := ''; -- No hubo errores
        RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Obtengo el error
            RETURN FALSE;
    END agregar_empleado;
    
-- ELIMINAR EMPLEADO -----------------------------------------------------------
    FUNCTION eliminar_empleado (
        p_employee_id IN employees.employee_id%TYPE,
        p_error_msg   OUT VARCHAR2
    ) RETURN BOOLEAN AS
    BEGIN
        -- Elimino registros de la tabla job_history que tienen a employee_id
        DELETE FROM job_history
        WHERE
            employee_id = p_employee_id;
    
        -- Establecer el manager_id de los empleados dependientes como NULL
        UPDATE employees
        SET
            manager_id = NULL
        WHERE
            manager_id = p_employee_id;
    
        -- Eliminar al empleado de la tabla employees
        DELETE FROM employees
        WHERE
            employee_id = p_employee_id;

        COMMIT;
        p_error_msg := ''; -- No hubo error
        RETURN TRUE;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Capturar el mensaje de error
            RETURN FALSE;
    END eliminar_empleado;

-- MODIFICAR EMPLEADO ----------------------------------------------------------
    FUNCTION modificar_empleado (
        p_employee_id    IN employees.employee_id%TYPE,
        p_first_name     IN employees.first_name%TYPE,
        p_last_name      IN employees.last_name%TYPE,
        p_email          IN employees.email%TYPE,
        p_phone_number   IN employees.phone_number%TYPE,
        p_hire_date      IN employees.hire_date%TYPE,
        p_job_id         IN employees.job_id%TYPE,
        p_salary         IN employees.salary%TYPE,
        p_commission_pct IN employees.commission_pct%TYPE,
        p_manager_id     IN employees.manager_id%TYPE,
        p_department_id  IN employees.department_id%TYPE,
        p_error_msg      OUT VARCHAR2
    ) RETURN BOOLEAN AS
    BEGIN
        UPDATE employees
        SET
            first_name = p_first_name,
            last_name = p_last_name,
            email = p_email,
            phone_number = p_phone_number,
            hire_date = p_hire_date,
            job_id = p_job_id,
            salary = p_salary,
            commission_pct = p_commission_pct,
            manager_id = p_manager_id,
            department_id = p_department_id
        WHERE
            employee_id = p_employee_id;

        COMMIT;
        p_error_msg := ''; -- No hubo error
        RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Capturar el mensaje de error
            RETURN FALSE;
    END modificar_empleado;

-- AGREGAR JOB ----------------------------------------------------------------
    FUNCTION agregar_puesto (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE,
        p_error_msg  OUT VARCHAR2
    ) RETURN BOOLEAN AS
    BEGIN
        INSERT INTO jobs (
            job_id,
            job_title,
            min_salary,
            max_salary
        ) VALUES (
            p_job_id,
            p_job_title,
            p_min_salary,
            p_max_salary
        );

        COMMIT;
        p_error_msg := ''; -- No hubo errores
        RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Obtengo el error
            RETURN FALSE;
    END agregar_puesto;
    
-- ELIMINAR JOB ---------------------------------------------------------------
    FUNCTION eliminar_puesto (
        p_job_id    IN jobs.job_id%TYPE,
        p_error_msg OUT VARCHAR2
    ) RETURN BOOLEAN AS
    BEGIN
        DELETE FROM jobs
        WHERE
            job_id = p_job_id;

        COMMIT;
        p_error_msg := ''; -- No hubo error
        RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Capturar el mensaje de error
            RETURN FALSE;
    END eliminar_puesto;
    
-- MODIFICAR PUESTO-------------------------------------------------------------
    FUNCTION modificar_puesto (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE,
        p_error_msg  OUT VARCHAR2
    ) RETURN BOOLEAN AS
    BEGIN
        UPDATE jobs
        SET
            job_title = p_job_title,
            min_salary = p_min_salary,
            max_salary = p_max_salary
        WHERE
            job_id = p_job_id;

        COMMIT; -- Confirmar los cambios en la base de datos
        p_error_msg := ''; -- No hubo error
        RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Capturar el mensaje de error
            RETURN FALSE;
    END modificar_puesto;

END pa_gestion_hr;