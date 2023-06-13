# Trabajo Práctico Final
Proyecto final del curso Oracle PL/SQL.

Tomás Martín Griffa Benitez (tgriffabenitez@gmail.com)


# PARTE I: PL/SQL
En esta parte adjunto todos los archivos relacionados a la base de datos de Oracle.

Aca estan los packages y funciones que cree para el trabajo final.


## PACKAGE PA_GESTION_HR
```sql
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
    ) RETURN NUMBER;
    
-- ELIMINAR EMPLEADO -----------------------------------------------------------
    FUNCTION eliminar_empleado (
        p_employee_id IN employees.employee_id%TYPE,
        p_error_msg   OUT VARCHAR2
    ) RETURN NUMBER;
    
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
    ) RETURN NUMBER;

-- AGREGAR PUESTO --------------------------------------------------------------
    FUNCTION agregar_puesto (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE,
        p_error_msg  OUT VARCHAR2
    ) RETURN NUMBER;
    
-- ELIMINAR PUESTO -------------------------------------------------------------
    FUNCTION eliminar_puesto (
        p_job_id    IN jobs.job_id%TYPE,
        p_error_msg OUT VARCHAR2
    ) RETURN NUMBER;
    
-- MODIFICAR PUESTO ------------------------------------------------------------
    FUNCTION modificar_puesto (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE,
        p_error_msg  OUT VARCHAR2
    ) RETURN NUMBER;

END pa_gestion_hr;
```

En este paquete se encuentran las funciones utilizadas para el ABM de un empleado y el ABM de un job. Inicialmente, en la consigna del trabajo, se pedía que todas las funciones devolvieran un valor booleano. Después de preguntarle a Germán, se decidió cambiar el tipo de retorno de la función por un valor numérico (1 en caso de éxito, -1 en caso de error). Esto se hizo para poder utilizar JDBC en el proyecto de Java, ya que JDBC no reconoce el tipo booleano de PL/SQL.

## FUNCIÓN `agregar_empleado()`

```sql
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
    ) RETURN NUMBER AS
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
        RETURN 1;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Obtengo el error
            RETURN -1;
    END agregar_empleado;
```

Esta función tiene como objetivo dar de alta un empleado. Se insertan los valores recibidos como parámetros en las columnas correspondientes y luego se realiza la solicitud con el comando commit. La función devuelve 1 en caso de éxito. En caso de error, devuelve -1 junto con un mensaje explicativo.

## FUNCION `eliminar_empleado()`
```sql
    FUNCTION eliminar_empleado (
        p_employee_id IN employees.employee_id%TYPE,
        p_error_msg   OUT VARCHAR2
    ) RETURN NUMBER AS
        v_cant_empleado NUMBER;
    BEGIN
    
        -- Verifico si existe el empleado a eliminar
        SELECT
            COUNT(*)
        INTO v_cant_empleado
        FROM
            employees
        WHERE
            employee_id = p_employee_id;

        IF v_cant_empleado = 0 THEN
            raise_application_error(-20001, 'No existe el empleado con el ID ingresado');
        END IF;
           
        -- Seteo el manager_id de los empleados dependientes como NULL
        UPDATE employees
        SET
            manager_id = NULL
        WHERE
            manager_id = p_employee_id;
            
        -- Seteo el manager_id de los departments en null
        UPDATE departments
        SET
            manager_id = NULL
        WHERE
            manager_id = p_employee_id;
    
        -- Baja logica del empleado
        UPDATE employees
        SET
            baja = sysdate
        WHERE
            employee_id = p_employee_id;

        COMMIT;
        p_error_msg := ''; -- No hubo error
        RETURN 1;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Capturar el mensaje de error
            RETURN -1;
    END eliminar_empleado;
```
Esta función se encarga de realizar la baja lógica de un empleado. Recibe como parámetros el ID del empleado y un mensaje que se devolverá en caso de error. En caso de éxito, la función devuelve 1; en caso de error, devuelve -1 junto con un mensaje.

En primer lugar, la función verifica si el ID ingresado existe en la base de datos. Si el ID ingresado no existe, se genera una excepción y se devuelve un mensaje de error.

A continuación, si el empleado que se está eliminando es el supervisor de otros empleados, se establece el valor nulo (null) en la columna de supervisor del empleado dependiente. Por ejemplo, si Juan es el supervisor de Marcos y quiero dar de baja a Juan, ahora Marcos tendrá el valor nulo en la columna de supervisor. Esto se hace para mantener la integridad referencial. Lo mismo se aplica en la tabla "departments", donde cada departamento tiene un supervisor.

Finalmente, una vez que se han realizado todas las modificaciones previas, se realiza la baja lógica. Esto implica asignar la fecha en la que se ejecutó esta función a la columna "baja" del empleado.

## FUNCIÓN `modificar_empleado()`
```sql
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
    ) RETURN NUMBER AS
        v_cant_empleado NUMBER;
    BEGIN
    
        -- Verifico si existe el empleado a modificar
        SELECT
            COUNT(*)
        INTO v_cant_empleado
        FROM
            employees
        WHERE
            employee_id = p_employee_id;

        IF v_cant_empleado = 0 THEN
            raise_application_error(-20001, 'No existe el empleado con el ID ingresado');
        END IF;
    
        -- Elimino del job_history el empleado que estoy updateando para que no 
        -- me genere errores
        DELETE FROM job_history
        WHERE
            employee_id = p_employee_id;
    
        -- Modifico los datos con los nuevos
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
        RETURN 1;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Capturar el mensaje de error
            RETURN -1;
    END modificar_empleado;
```

Esta función se encarga de actualizar los datos de un empleado. En caso de éxito, devuelve 1; en caso de error, devuelve -1 junto con un mensaje.

En primer lugar, se verifica si existe el ID del empleado que se desea actualizar. Si el ID del empleado no existe, se genera una excepción y se devuelve un mensaje de error.

De la tabla job_history elimino el empleado que estoy modificando, esto tuve que hacerlo ya que sino no me resultaba posible editar al mismo empleado mas de dos veces.

Luego, se procede a realizar la actualización del empleado. Se llevan a cabo las modificaciones correspondientes en los datos. Si todas las actualizaciones se realizan correctamente, la función devuelve 1.

Si ocurre algún error durante la actualización, se devuelve -1 junto con un mensaje explicativo.

## FUNCIÓN `agregar_puesto()`
```sql
    FUNCTION agregar_puesto (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE,
        p_error_msg  OUT VARCHAR2
    ) RETURN NUMBER AS
        v_cant_job NUMBER;
        v_baja_job jobs.baja%TYPE;
    BEGIN
    
        -- Verifico si ya existe un job con ese id
        SELECT
            COUNT(*)
        INTO v_cant_job
        FROM
            jobs
        WHERE
            job_id = p_job_id;

        -- Verifico si existe el job en la base de datos
        IF v_cant_job > 0 THEN
            -- Verifico si el job existente tiene una baja logica
            SELECT
                baja
            INTO v_baja_job
            FROM
                jobs
            WHERE
                job_id = p_job_id;
                
            -- si baja es distinto de null quiere decir que tiene una fecha de baja
            -- entonces lo doy de alta nuevamente
            IF v_baja_job IS NOT NULL THEN
                UPDATE jobs
                    SET
                        baja = NULL
                    WHERE
                        job_id = p_job_id;
                RETURN 1;
                
            -- si baja es igual a null quiere decir que el job existente no esta dado de baja
            -- entonces es un valor repetido
            ELSE
                raise_application_error(-20001, 'Ya existe un job con ese id');
            END IF;
        END IF;

        -- si no existe, lo creo
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
        RETURN 1;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Obtengo el error
            RETURN -1;
    END agregar_puesto;
```

Esta función se encarga de dar de alta un puesto de trabajo.

En primer lugar, se verifica si existe un trabajo con el mismo ID que se está ingresando para dar de alta. Si se encuentra un trabajo con ese ID en la base de datos, pueden darse dos casos:

1. El trabajo se encuentra activo.
2. El trabajo fue dado de baja anteriormente.

Si se cumple el caso 1, se genera una excepción y se devuelve un mensaje de error. Si se cumple el caso 2, se procede a dar de alta el trabajo.

En caso de ingresar un ID que no cumple ninguna de las condiciones anteriores (caso 1 o caso 2), se procede a dar de alta el trabajo.

## FUNCÓN `eliminar_puesto()`
```sql
  FUNCTION eliminar_puesto (
        p_job_id    IN jobs.job_id%TYPE,
        p_error_msg OUT VARCHAR2
    ) RETURN NUMBER AS
        v_cant_job NUMBER;
    BEGIN
    
        -- Verifico si existe el job a eliminar
        SELECT
            COUNT(*)
        INTO v_cant_job
        FROM
            jobs
        WHERE
            job_id = p_job_id;

        IF v_cant_job = 0 THEN
            raise_application_error(-20001, 'No existe el job con el ID ingresado');
        END IF;
    
        -- Asigno el job_id XX_XXX a todos los empleados cuyo job_id estoy borrando
        UPDATE employees
        SET
            job_id = 'XX_XXX'
        WHERE
            job_id = p_job_id;
    
        -- Baja logica del job
        UPDATE jobs
        SET
            baja = sysdate
        WHERE
            job_id = p_job_id;

        COMMIT;
        p_error_msg := ''; -- No hubo error
        RETURN 1;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Capturar el mensaje de error
            RETURN -1;
    END eliminar_puesto;
```

Esta funcion realiza una baja logia de un puesto de trabajo. Por parametro recibe el id del puesto y un mensaje que en caso de error sera devuelto. Devuelve un 1 en caso de exito y en caso de error un -1 junto con un mensaje.

Primeramente se verifica que el id del job a eliminar exista en la base de datos, si no existe se lanza una excepcion y se devuelve un mensaje de error.

Si el id del puesto existe en la base de datos, a todos los empleados que tienen ese puesto se les les asigna el pusto con id XX_XXX. Esto es para mantener la integridad referencial (aparte no tiene sentido que los empleados tengan un puesto que fue borrado).

Por ultimo, se realiza la baja logica insertando la fecha en la que fue ejecutada esta funcion.

## FUNCIÓN `modificar_puesto()`
```sql
    FUNCTION modificar_puesto (
        p_job_id     IN jobs.job_id%TYPE,
        p_job_title  IN jobs.job_title%TYPE,
        p_min_salary IN jobs.min_salary%TYPE,
        p_max_salary IN jobs.max_salary%TYPE,
        p_error_msg  OUT VARCHAR2
    ) RETURN NUMBER AS
        v_cant_job NUMBER;
    BEGIN
    
        -- Verifico si existe un job con ese id
        SELECT
            COUNT(*)
        INTO v_cant_job
        FROM
            jobs
        WHERE
            job_id = p_job_id;

        IF v_cant_job = 0 THEN
            raise_application_error(-20001, 'No existe un job con ese id');
        END IF;

        -- Actualizo los campos con los nuevos valores ingresados
        UPDATE jobs
        SET
            job_title = p_job_title,
            min_salary = p_min_salary,
            max_salary = p_max_salary
        WHERE
            job_id = p_job_id;

        COMMIT; -- Confirmar los cambios en la base de datos
        p_error_msg := ''; -- No hubo error
        RETURN 1;
    EXCEPTION
        WHEN OTHERS THEN
            p_error_msg := sqlerrm; -- Capturar el mensaje de error
            RETURN -1;
    END modificar_puesto;
```

Esta función se encarga de realizar una baja lógica de un puesto de trabajo. Recibe como parámetros el ID del puesto y un mensaje que se devolverá en caso de error. Devuelve 1 en caso de éxito y, en caso de error, devuelve -1 junto con un mensaje.

En primer lugar, se verifica si el ID del puesto a eliminar existe en la base de datos. Si el ID no existe, se genera una excepción y se devuelve un mensaje de error.

Si el ID del puesto existe en la base de datos, se realiza la siguiente acción: a todos los empleados que tienen ese puesto se les asigna un puesto con un ID especial (por ejemplo, XX_XXX). Esto se hace para mantener la integridad referencial y además no tiene sentido que los empleados tengan un puesto que ha sido eliminado.

Finalmente, se realiza la baja lógica del puesto insertando la fecha en la que se ejecutó esta función en la columna correspondiente.

## ALTA USUARIO `amb_hr`
```sql
-- Creo el usuario "ABM_HR"
CREATE USER ABM_HR
IDENTIFIED BY "oracle"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK;

-- Otorgar los roles y privilegios necesarios al usuario "ABM_HR"
GRANT CREATE SESSION TO ABM_HR;
GRANT CONNECT, RESOURCE TO ABM_HR;
GRANT SELECT_CATALOG_ROLE TO ABM_HR;
```
Con el siguiente scrip se dio de alta al usuario `abm_hr`. A este usuario se le asignaron los permisos correspondientes para poder ejecutar el package `PA_GESTION_HR`.

## BAJA LÓGICA
```sql
ALTER TABLE employees ADD (baja DATE);
ALTER TABLE JOBS ADD (baja DATE);
```
Script para agregar la columna "baja" para poder realizar las bajas lógicas en las tablas _employees_ y _jobs_.

# PARTE II: JAVA

En esta parte, explicaré el funcionamiento de la aplicación de escritorio de Java para realizar consultas a la base de datos.

## INICIO DE LA APLICACIÓN

Cuando se inicie el programa, aparecerá una pequeña ventana que solicitará la introducción de la dirección IP y el puerto de la base de datos. Esto se hace evitar tener que modificar el código fuente.

La dirección IP que se debe ingresar es la misma que se utiliza en la conexión de las tablas HR, AMB_HR y HR_SYS. La contraseña está "hardcodeada" en el programa y en todos los casos es "`oracle`".

El puerto es el `1521`, que también se utilizó durante la instalación de la base de datos HR.
Menú de tablas

Una vez presionado el botón "Contentar", aparecerá una nueva ventana.

En esta ventana, hay dos botones para seleccionar la tabla que se desea modificar (Employee / Jobs).

## TABLA EMPLOYEES

Para cargar los valores, es importante tener una columna en la tabla employees llamada `baja`. Esto es fundamental, ya que se realiza la siguiente consulta:

```sql
SELECT * FROM hr.employees WHERE baja IS NULL ORDER BY hr.employee_id DESC
```

De esta manera, se obtienen todos los datos de los empleados que no han sido dados de baja, ordenados de forma descendente según el ID.

En el panel de la izquierda, se puede dar de alta un nuevo empleado rellenando todos los campos y haciendo clic en el botón "Añadir". Con el botón "Limpiar", se pueden borrar todos los campos en caso de querer cancelar la operación de alta.

En la parte superior derecha se encuentran los botones "Modificar" y "Eliminar". Para utilizar estos botones, primero se debe seleccionar un registro de la tabla, ya que al hacerlo se obtiene su ID.

Cuando se presiona el botón "Modificar", se abre una nueva ventana con los campos correspondientes para realizar las modificaciones. Dado que los IDs son claves primarias, no se pueden eliminar.

Cuando se presiona el botón "Eliminar", se realiza una baja lógica del registro asignándole la fecha de baja. Internamente, después de realizar una alta, baja o modificación, se vuelve a hacer una consulta a la base de datos para recargar la tabla y observar los cambios al instante.

## TABLA JOBS

Su funcionamiento es exactamente igual al de la tabla "Employee", con la diferencia de que se trabaja con los datos de la tabla "Jobs".


## CONSIDERACIONES

Es importante destacar que en la capa de servicios, los archivos DAOImpl llaman a funciones específicas que corresponden a mi paquete, el cual se explica más arriba. Este programa no funciona con tablas/funciones que no tengan los mismos parámetros y/o atributos.
