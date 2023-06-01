CREATE OR REPLACE PACKAGE BODY pa_gestion_hr IS
    -- Función para dar de alta un empleado
    FUNCTION alta_empleado (
        p_employee_id   IN NUMBER,
        p_first_name    IN VARCHAR2,
        p_last_name     IN VARCHAR2,
        p_email         IN VARCHAR2,
        p_phone_number  IN VARCHAR2,
        p_hire_date     IN DATE,
        p_job_id        IN VARCHAR2,
        p_salary        IN NUMBER,
        p_manager_id    IN NUMBER,
        p_department_id IN NUMBER
    ) RETURN BOOLEAN IS
        v_error_msg VARCHAR2(200);
    BEGIN
        INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            manager_id,
            department_id
        ) VALUES (
            p_employee_id,
            p_first_name,
            p_last_name,
            p_email,
            p_phone_number,
            p_hire_date,
            p_job_id,
            p_salary,
            p_manager_id,
            p_department_id
        );

        COMMIT;
        RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            v_error_msg := sqlerrm;
            RETURN FALSE;
    END alta_empleado;

    -- Función para dar de baja un empleado --
    FUNCTION baja_empleado (
        p_employee_id IN NUMBER
    ) RETURN BOOLEAN IS
        v_error_msg VARCHAR2(200);
    BEGIN
    
        -- Eliminar registros relacionados en job_history
        DELETE FROM job_history
        WHERE employee_id = p_employee_id;
    
        -- Eliminar registro del empleado en la tabla "employees"
        DELETE FROM employees
        WHERE employee_id = p_employee_id;
    
        COMMIT;
        RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            v_error_msg := sqlerrm;
            RETURN FALSE;
    END baja_empleado;

    -- Función para modificar un empleado --
    FUNCTION modificar_empleado (
        p_employee_id   IN NUMBER,
        p_first_name    IN VARCHAR2,
        p_last_name     IN VARCHAR2,
        p_email         IN VARCHAR2,
        p_phone_number  IN VARCHAR2,
        p_hire_date     IN DATE,
        p_job_id        IN VARCHAR2,
        p_salary        IN NUMBER,
        p_manager_id    IN NUMBER,
        p_department_id IN NUMBER
    ) RETURN BOOLEAN IS
        v_error_msg VARCHAR2(200);
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
            manager_id = p_manager_id,
            department_id = p_department_id
        WHERE
            employee_id = p_employee_id;

        COMMIT;
        RETURN TRUE;
    EXCEPTION
        WHEN OTHERS THEN
            v_error_msg := sqlerrm;
            RETURN FALSE;
    END modificar_empleado;

END pa_gestion_hr;