--@Autor: Santiago Sánchez Sánchez
--@Fecha creación: 23/03/2025
--@Descripción: Archivo de conteo de registros en fragmentos creados en ambos nodos

-- Manejo de errores
whenever sqlerror exit rollback;

-- Conectar a S1
Prompt Conectando a S1
connect editorial_bdd/editorial_bdd@sssbdd_s1;

Prompt Realizando conteo de registros en S1

SELECT 
    (SELECT COUNT(*) FROM F_SSS_PAIS_1) AS PAIS_1,
    (SELECT COUNT(*) FROM F_SSS_SUSCRIPTOR_1) AS SUSCRIPTOR_1,
    (SELECT COUNT(*) FROM F_SSS_SUSCRIPTOR_2) AS SUSCRIPTOR_2,
    (SELECT COUNT(*) FROM F_SSS_SUSCRIPTOR_3) AS SUSCRIPTOR_3,
    (SELECT COUNT(*) FROM F_SSS_ARTICULO_2) AS ARTICULO_2,
    (SELECT COUNT(*) FROM F_SSS_REVISTA_1) AS REVISTA_1,
    (SELECT COUNT(*) FROM F_SSS_ARTICULO_REVISTA_1) AS ARTICULO_REVISTA_1,
    (SELECT COUNT(*) FROM F_SSS_PAGO_SUSCRIPTOR_1) AS PAGO_SUSCRIPTOR_1
FROM dual;

-- Conectar a S2
Prompt Conectando a S2
connect editorial_bdd/editorial_bdd@sssbdd_s2;

Prompt Realizando conteo de registros en S2

SELECT 
    (SELECT COUNT(*) FROM F_SSS_PAIS_2) AS PAIS_2,
    (SELECT COUNT(*) FROM F_SSS_SUSCRIPTOR_4) AS SUSCRIPTOR_4,
    (SELECT COUNT(*) FROM F_SSS_ARTICULO_1) AS ARTICULO_1,
    (SELECT COUNT(*) FROM F_SSS_REVISTA_2) AS REVISTA_2,
    (SELECT COUNT(*) FROM F_SSS_ARTICULO_REVISTA_2) AS ARTICULO_REVISTA_2,
    (SELECT COUNT(*) FROM F_SSS_PAGO_SUSCRIPTOR_2) AS PAGO_SUSCRIPTOR_2
FROM dual;

Prompt Conteo de registros completado.
exit;

