DECLARE
    --- Declaracion de variables ---
    v_mensaje varchar2(255);
    v_numero1 number;
    v_numero2 number;
    v_fecha date;
    
BEGIN
    --- Inicializacion de variables ---
    v_mensaje := 'Hola mundo!!';
    v_numero1 := 10;
    v_numero2 := 0;
    v_fecha := sysdate;
    
    --- Salida por stdout ---
    DBMS_OUTPUT.PUT_LINE(v_mensaje);
    DBMS_OUTPUT.PUT_LINE(v_numero1);  
    DBMS_OUTPUT.PUT_LINE(v_fecha);
    
    --- Para concatenar variables se usa el ||
    v_mensaje := v_mensaje || ' hoy es ' || TO_CHAR(v_fecha, 'dd/mm/yyy') || ' y hacen ' || TO_CHAR(v_numero1) || ' grados';
    DBMS_OUTPUT.PUT_LINE(v_mensaje);
    
    --- Genero un exception dividiendo por cero ---
    v_numero1 := v_numero1 / v_numero2;

EXCEPTION WHEN OTHERS THEN
    --- Muestro el mensaje de error por stdout ---
    DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;