create or replace PACKAGE    pa_util AS
    TYPE t_split IS
        TABLE OF VARCHAR2(32767);
    FUNCTION fn_dividircadena (
        p_vlista IN VARCHAR2,
        p_vdelim IN VARCHAR2 := ';'
    ) RETURN t_split
        PIPELINED;

    FUNCTION fn_split (
        p_linea_datos VARCHAR2,
        p_delim       VARCHAR2
    ) RETURN t_split;

END pa_util;
