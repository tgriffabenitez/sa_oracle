CREATE OR REPLACE PACKAGE pa_gestion_HR IS
  -- Función para dar de alta un empleado
  FUNCTION alta_empleado(
    p_employee_id   IN  NUMBER,
    p_first_name    IN  VARCHAR2,
    p_last_name     IN  VARCHAR2,
    p_email         IN  VARCHAR2,
    p_phone_number  IN  VARCHAR2,
    p_hire_date     IN  DATE,
    p_job_id        IN  VARCHAR2,
    p_salary        IN  NUMBER,
    p_manager_id    IN  NUMBER,
    p_department_id IN  NUMBER
  ) RETURN BOOLEAN;

  -- Función para dar de baja un empleado
  FUNCTION baja_empleado(p_employee_id IN NUMBER) RETURN BOOLEAN;

  -- Función para modificar los datos de un empleado
  FUNCTION modificar_empleado(
    p_employee_id   IN  NUMBER,
    p_first_name    IN  VARCHAR2,
    p_last_name     IN  VARCHAR2,
    p_email         IN  VARCHAR2,
    p_phone_number  IN  VARCHAR2,
    p_hire_date     IN  DATE,
    p_job_id        IN  VARCHAR2,
    p_salary        IN  NUMBER,
    p_manager_id    IN  NUMBER,
    p_department_id IN  NUMBER
  ) RETURN BOOLEAN;
  
END pa_gestion_HR;