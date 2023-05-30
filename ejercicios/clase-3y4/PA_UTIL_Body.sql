create or replace PACKAGE BODY    pa_util AS

    FUNCTION fn_dividircadena (
        p_vlista IN VARCHAR2,
        p_vdelim IN VARCHAR2 := ';'
    ) RETURN t_split
        PIPELINED
    IS
        v_nidx   PLS_INTEGER;
        v_vlista VARCHAR2(32767) := p_vlista;
    BEGIN
        LOOP
            v_nidx := instr(v_vlista, p_vdelim);
            IF v_nidx > 0 THEN
                PIPE ROW ( substr(v_vlista, 1, v_nidx - 1) );
                v_vlista := substr(v_vlista, v_nidx + length(p_vdelim));
            ELSE
                PIPE ROW ( v_vlista );
                EXIT;
            END IF;

        END LOOP;

        RETURN;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('SQLERRM:' || to_char(sqlerrm));
            RETURN;
    END;

    FUNCTION fn_split (
        p_linea_datos VARCHAR2,
        p_delim       VARCHAR2
    ) RETURN t_split AS

        v_dato_aux   VARCHAR2(1000);
        v_vdelim     VARCHAR2(1) := p_delim;
        v_indx       NUMBER := 1;
        v_datos_fila t_split := t_split();
    BEGIN
        v_vdelim := nvl(p_delim, ';');
        v_indx := 1;

      -- Arma vector
        FOR rec IN (
            SELECT
                *
            FROM
                TABLE ( fn_dividircadena(p_linea_datos, v_vdelim) )
        ) LOOP
         -- Un dato de la linea
            v_dato_aux := trim(rec.column_value);

         -- Agregar la columna al arreglo
            v_datos_fila.extend;
            v_datos_fila(v_indx) := v_dato_aux;

         -- Incrementar indice
            v_indx := v_indx + 1;
            EXIT WHEN v_indx = 500000;
        END LOOP;

        RETURN v_datos_fila;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line(sqlerrm);
    END;

END pa_util;
