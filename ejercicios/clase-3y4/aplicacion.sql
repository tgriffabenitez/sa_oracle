DECLARE
    arr_datos           pa_util.t_split;
    p_linea_datos       VARCHAR2(32767);
    p_delim             VARCHAR2(32767);
    i                   INTEGER;

BEGIN
    p_linea_datos :=
        '121;Tomas;Griffa;TGRIFFA;111.111.1111;03/09/1996;ST_MAN;8200;;100;50';
    p_delim := ';';
    
    arr_datos := hr.pa_util.fn_split(p_linea_datos, p_delim);
    
    dbms_output.put_line('arr_datos.Count:' || arr_datos.count);
    dbms_output.put_line('arr_datos(2):' || arr_datos(2));
    
    FOR i IN arr_datos.first .. arr_datos.last
    LOOP
        dbms_output.put_line(arr_datos(i));
    END LOOP;
    COMMIT;
END;