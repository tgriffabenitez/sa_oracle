# Ejercicios de la clase 3 y 4 - tgriffabenitez

## Package `pa_utils`
```slq
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
```
Este package contiene dos funciones para dividir una cadena de texto en elementos más pequeños utilizando un delimitador específico.

La función `fn_dividircadena` y tiene dos parámetros de entrada: `p_vlista` que es una cadena de texto y `p_vdelim` que es un delimitador opcional. Esta función devuelve un tipo de tabla llamado `t_split`, que es una tabla de valores de tipo VARCHAR2 con una longitud máxima de 32767 caracteres. Esta función utiliza un pipeline para devolver los resultados.

La función `fn_split` y tiene dos parámetros de entrada: `p_linea_datos` que es una cadena de texto y `p_delim` que es un delimitador. Al igual que la función anterior, devuelve el tipo de tabla `t_split`. Esta función también utiliza un pipeline para devolver los resultados.

## Package body `pa_utils`
```sql
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
```

El Package body proporciona la implementación de las funciones previamente declaradas en el package

La primera función del cuerpo del package es `fn_dividircadena`. Esta función utiliza un bucle para dividir una cadena de texto (p_vlista) en elementos más pequeños utilizando un delimitador (p_vdelim). Cada elemento se va enviando en un pipeline (PIPE ROW) para ser devuelto como parte del tipo de tabla `t_split`. El bucle continúa hasta que ya no se encuentren más ocurrencias del delimitador en la cadena. Si se produce alguna excepción durante la ejecución, se captura y se muestra el mensaje de error utilizando la función `dbms_output.put_line`.

La segunda función del cuerpo del package es `fn_split`. Esta función utiliza la función `fn_dividircadena` anteriormente definida para dividir una línea de datos (p_linea_datos) en elementos más pequeños utilizando un delimitador (p_delim). Los elementos divididos se almacenan en un array llamado `v_datos_fila` de tipo `t_split`. El bucle FOR recorre los elementos devueltos por la función `fn_dividircadena` y los agrega al array. El bucle se detiene cuando se han agregado 500,000 elementos al array. Si se produce alguna excepción durante la ejecución, se captura y se muestra el mensaje de error utilizando la función `dbms_output.put_line`.

## Implementacion
![implementacion](implementacion.png)