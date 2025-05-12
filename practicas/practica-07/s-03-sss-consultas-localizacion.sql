--@Autor: Santiago Sanchez Sanchez
--@Fecha creación: 19/04/2025
--@Descripción: Conteo atraves de sinonimos
 
 DECLARE
    pais_counter number;
    suscriptor_counter number;
    articulo_counter number;
    articulo_revista_counter number;
    pago_suscriptor_counter number;
    revista_counter number;

BEGIN
    dbms_output.put_line('Realizando consulta empleando sinonimos');

-- Para PAIS
    SELECT COUNT(*) INTO pais_counter
    FROM (
        SELECT pais_id
        FROM pais_1
        UNION ALL
        SELECT pais_id
        FROM pais_2
    ) q1;

-- Para SUSCRIPTOR
    SELECT COUNT(*) INTO suscriptor_counter
    FROM (
        SELECT suscriptor_id
        FROM (
            SELECT suscriptor_id
            FROM suscriptor_3
            UNION ALL
            SELECT suscriptor_id
            FROM suscriptor_4
        ) q2
        UNION ALL
        SELECT suscriptor_id
        FROM suscriptor_2
    ) q3;

-- Para Articulo
    SELECT COUNT(*) INTO articulo_counter
    FROM (
        SELECT articulo_id
        FROM articulo_2
    ) q4;

-- Para Revista
    SELECT COUNT(*) INTO revista_counter
    FROM (
        SELECT revista_id
        FROM revista_1
        UNION ALL
        SELECT revista_id
        FROM revista_2
    ) q5;

-- Para Articulo Revista
    SELECT COUNT(*) INTO articulo_revista_counter
    FROM (
        SELECT articulo_revista_id
        FROM articulo_revista_1
        UNION ALL
        SELECT articulo_revista_id
        FROM articulo_revista_2
    ) q6;

-- Para Pago Suscriptor
    SELECT COUNT(*) INTO pago_suscriptor_counter
    FROM (
        SELECT num_pago
        FROM pago_suscriptor_1
        UNION ALL
        SELECT num_pago
        FROM pago_suscriptor_2
    ) q7;

-- realizar el mismo procedimiento para las demás tablas.
    dbms_output.put_line('Resultado del conteo de registros');
    dbms_output.put_line('Paises: '||pais_counter);
    dbms_output.put_line('Suscriptores: '||suscriptor_counter);
    dbms_output.put_line('Articulos: '||articulo_counter);
    dbms_output.put_line('Revistas: '||revista_counter);
    dbms_output.put_line('Articulos Revistas: '||articulo_revista_counter);
    dbms_output.put_line('Pago Suscriptor: '||pago_suscriptor_counter);
END;
/
Prompt Listo