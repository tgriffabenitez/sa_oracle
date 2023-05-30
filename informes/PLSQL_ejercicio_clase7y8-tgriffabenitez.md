# Ejercicios de la clase 7 y 8 - tgriffabenitez

## Archivo `grant_debug.sql`
```sql
CREATE DIRECTORY reportes AS '/tmp/curso_ora/reportes'; 
GRANT READ ON DIRECTORY reportes TO HR; 
GRANT WRITE ON DIRECTORY reportes TO HR;
```
Creo el directorio `/tmp/curso_ora/reportes` y le otorgo permisos de escritura y lectura al usuario HR.


### Prueba `grant_debug.sql`
![prueba_grant-debug](prueba_directorio.png)

Como se puede ver en la imagen, el directorio fue creado correctamente.

## Procedure `emp_report`
```sql
 -- Para sacar un reporte por archivo texto plano
    PROCEDURE emp_report (
        p_nom_archivo VARCHAR2,
        p_ruta        VARCHAR2
    ) IS

        archivo      VARCHAR2(1000) := p_nom_archivo;
        dir          VARCHAR2(4000) := p_ruta;
        resultado    NUMBER;
        fecha_hoy    VARCHAR(50);
        fechaarchivo VARCHAR(50);
        file_type    utl_file.file_type;
        i            NUMBER := 0;
        v_cnt        NUMBER := 0;
        lineaarchivo VARCHAR2(4000);
        CURSOR c_filas IS
        SELECT
            employee_id,
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
        FROM
            employees
        ORDER BY
            first_name;

        cabecera     VARCHAR2(3000) := '';
        pie          VARCHAR2(3000) := '';
        cant         NUMBER := 0;
        trail        VARCHAR2(100);
    BEGIN
        SELECT
            to_char(sysdate, 'MM/DD/YYYY')
        INTO fecha_hoy
        FROM
            dual;

        resultado := 0;

      --fecha para armar el nombre del archivo
        SELECT
            to_char(sysdate, 'YYYYMMDD')
        INTO fechaarchivo
        FROM
            dual;

        dir := nvl(dir, '/tmp/curso_ora/reportes');
        archivo := nvl(archivo, 'empleados_')
                   || fechaarchivo
                   || '.txt';
        dbms_output.put_line(dir);
        dbms_output.put_line(archivo
                             || fechaarchivo
                             || '.txt');
        --return;
        file_type := sys.utl_file.fopen(dir, archivo, 'W', 30000);             ---abro el archivo para escritura
        sys.utl_file.fflush(file_type);
        dbms_output.put_line('P1');
      ---------------------------------------------------------------
      -- Escribo la cabecera del archivo
        cabecera := 'EMPLOYEE_ID; FIRST_NAME; LAST_NAME; EMAIL; PHONE_NUMBER; HIRE_DATE; JOB_ID; SALARY; COMMISSION_PCT; MANAGER_ID; DEPARTMENT_ID'
        ;
        sys.utl_file.fflush(file_type);
        sys.utl_file.put_line(file_type, cabecera);

      --    Abro el cursor y escribo las lineas en el archivo
        FOR r_fila IN c_filas LOOP
            lineaarchivo := to_char(r_fila.employee_id)
                            || ';'
                            || r_fila.first_name
                            || ';'
                            || r_fila.last_name
                            || ';'
                            || r_fila.email
                            || ';'
                            || r_fila.phone_number
                            || ';'
                            || to_char(r_fila.hire_date, 'dd/mm/yyyy')
                            || ';'
                            || r_fila.job_id
                            || ';'
                            || to_char(r_fila.salary)
                            || ';'
                            || to_char(r_fila.commission_pct)
                            || ';'
                            || to_char(r_fila.manager_id)
                            || ';'
                            || to_char(r_fila.department_id);

            sys.utl_file.fflush(file_type);
            sys.utl_file.put_line(file_type, lineaarchivo);
            cant := cant + 1;
        END LOOP;

        utl_file.fflush(file_type);
        utl_file.fclose(file_type);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            sys.utl_file.fflush(file_type);
            sys.utl_file.put_line(file_type, 'Error '
                                             || sqlcode
                                             || ', '
                                             || sqlerrm);

            sys.utl_file.fclose(file_type);
    END;
```

Este procedure se encarga de generar un informe en formato de archivo de texto plano. Recibe dos parámetros de entrada: `p_nom_archivo` para especificar el nombre del archivo y `p_ruta` para indicar la ruta donde se guardará el archivo.

Dentro del procedure se obtiene la fecha actual y se construye el nombre del archivo utilizando la fecha y el nombre proporcionado. Se establece una ruta predeterminada si no se especifica una.

Luego, se abre el archivo en modo de escritura utilizando la función `sys.utl_file.fopen` y se escribe la cabecera en la primera línea del archivo. A continuación, se abre un cursor que selecciona todas las filas de la tabla `employees` ordenadas por el campo `first_name`.

Dentro de un bucle, se recorren las filas del cursor y se construye una línea de archivo de texto con los valores de cada columna. Esta línea se escribe en el archivo. También se incrementa un contador de registros procesados.

Finalmente, se cierra el archivo utilizando la función `sys.utl_file.fclose`. En caso de producirse una excepción durante la ejecución, se captura el error, se escribe un mensaje de error en el archivo y se cierra correctamente.


## Aplicacion
```sql
declare
  	p_nom_archivo varchar2(200);
 	p_ruta varchar2(200);
begin
 	p_nom_archivo := 'empleados_';
 	p_ruta := 'REPORTES';
  	hr_pack.emp_report(p_nom_archivo => p_nom_archivo,p_ruta => p_ruta);
end;
```

En este bloque anónimo, se declaran dos variables: `p_nom_archivo` y `p_ruta`, ambas de tipo VARCHAR2 con una longitud máxima de 200 caracteres. A continuación, se asignan valores a estas variables: `'empleados_'` se asigna a `p_nom_archivo` y `'REPORTES'` se asigna a `p_ruta`.

Después de la asignación de valores, se realiza una llamada al procedimiento almacenado `hr_pack.emp_report`. Los valores de las variables `p_nom_archivo` y `p_ruta` se pasan como parámetros en la llamada al procedimiento.

## Funcionamiento
![funcionamiento](prueba_reportes.png)

Para facilitar la lectura en la consola PuTTY se utilizo el comando de bash `head` que imprime las primeras 10 lineas de un archivo (`cat` hubiese imprimido todo el archivo en la consola).