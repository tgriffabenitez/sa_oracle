create or replace PACKAGE pa_gestion_hr IS
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
    ) RETURN BOOLEAN;
    
-- ELIMINAR EMPLEADO -----------------------------------------------------------
    FUNCTION eliminar_empleado (
        p_employee_id IN employees.employee_id%TYPE,
        p_error_msg   OUT VARCHAR2
    ) RETURN BOOLEAN;
    
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
    ) RETURN BOOLEAN;

-- AGREGAR PUESTO --------------------------------------------------------------
    FUNCTION agregar_puesto (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE,
        p_error_msg  OUT VARCHAR2
    ) RETURN BOOLEAN;
    
-- ELIMINAR PUESTO -------------------------------------------------------------
    FUNCTION eliminar_puesto (
        p_job_id    IN jobs.job_id%TYPE,
        p_error_msg OUT VARCHAR2
    ) RETURN BOOLEAN;
    
-- MODIFICAR PUESTO ------------------------------------------------------------
    FUNCTION modificar_puesto (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE,
        p_error_msg  OUT VARCHAR2
    ) RETURN BOOLEAN;

END pa_gestion_hr;