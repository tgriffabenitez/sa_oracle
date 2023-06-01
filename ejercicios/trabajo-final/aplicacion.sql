-- AGREGAR JOBS ----------------------------------------------------------------
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
--------------------------------------------------------------------------------

-- ELIMINAR JOBS ---------------------------------------------------------------
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
--------------------------------------------------------------------------------

-- ELIMINAR EMPLEADO -----------------------------------------------------------
DECLARE
  v_employee_id  employees.employee_id%TYPE := 100;
  v_error_msg    VARCHAR2(200);
  v_result       BOOLEAN;
BEGIN
  -- Llamar a la función eliminar_empleado
  v_result := pa_gestion_hr.eliminar_empleado(v_employee_id, v_error_msg);
  
  IF v_result THEN
    DBMS_OUTPUT.PUT_LINE('El empleado ha sido eliminado exitosamente.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Error al eliminar el empleado: ' || v_error_msg);
  END IF;
END;
--------------------------------------------------------------------------------