
-- @Autor: Santiago Sánchez Sánchez
-- @Fecha creación: 19/04/2025
-- @Descripción: Consultas con transparencia de fragmentación (formato mejorado)

-- Configuración de salida
SET SERVEROUTPUT ON
SET LINESIZE 100
SET PAGESIZE 100
SET FEEDBACK OFF
SET VERIFY OFF
WHENEVER SQLERROR EXIT ROLLBACK;

-- Consulta en SITIO 1
PROMPT conectando a sitio s1
CONNECT editorial_bdd/editorial_bdd@sssbdd_s1;

PROMPT Realizando conteo de registros
SELECT 
    (SELECT COUNT(*) FROM pais) AS PAIS,
    (SELECT COUNT(*) FROM suscriptor) AS SUSCRIPTOR,
    (SELECT COUNT(*) FROM articulo) AS ARTICULO,
    (SELECT COUNT(*) FROM revista) AS REVISTA,
    (SELECT COUNT(*) FROM articulo_revista) AS ARTICULO_REVISTA,
    (SELECT COUNT(*) FROM pago_suscriptor) AS PAGO_SUSCRIPTOR
FROM dual;

-- Consulta en SITIO 2
PROMPT conectando a sitio s2
CONNECT editorial_bdd/editorial_bdd@sssbdd_s2;

PROMPT Realizando conteo de registros
SELECT 
    (SELECT COUNT(*) FROM pais) AS PAIS,
    (SELECT COUNT(*) FROM suscriptor) AS SUSCRIPTOR,
    (SELECT COUNT(*) FROM articulo) AS ARTICULO,
    (SELECT COUNT(*) FROM revista) AS REVISTA,
    (SELECT COUNT(*) FROM articulo_revista) AS ARTICULO_REVISTA,
    (SELECT COUNT(*) FROM pago_suscriptor) AS PAGO_SUSCRIPTOR
FROM dual;

PROMPT listo.
SET FEEDBACK ON
SET VERIFY ON