-- @Autor: Santiago Sánchez Sánchez
-- @Fecha creación: 19/04/2025
-- @Descripción: Validación de vistas con columnas BLOB

-- Configuración de entorno
SET SERVEROUTPUT ON
SET LINESIZE 200
SET PAGESIZE 100
SET FEEDBACK OFF
WHENEVER SQLERROR EXIT ROLLBACK;

-- =============================================
-- CONEXIÓN A SITIO 1 (sssbdd_s1)
-- =============================================
PROMPT Conectándose a sssbdd_s1.fi.unam
CONNECT editorial_bdd/editorial_bdd@sssbdd_s1;

-- Validación para PAGO_SUSCRIPTOR (Fragmentación Horizontal)
PROMPT ====================================
PROMPT PAGO_SUSCRIPTOR - Estrategia 1
PROMPT ====================================
SELECT num_pago, DBMS_LOB.GETLENGTH(recibo_pago) AS longitud_recibo
FROM pago_suscriptor_e1
WHERE DBMS_LOB.GETLENGTH(recibo_pago) > 0;

PROMPT ====================================
PROMPT PAGO_SUSCRIPTOR - Estrategia 2
PROMPT ====================================
SELECT num_pago, DBMS_LOB.GETLENGTH(recibo_pago) AS longitud_recibo
FROM pago_suscriptor_e2
WHERE DBMS_LOB.GETLENGTH(recibo_pago) > 0;

PROMPT ====================================
PROMPT PAGO_SUSCRIPTOR - Sinónimo (Estrategia 2)
PROMPT ====================================
SELECT num_pago, DBMS_LOB.GETLENGTH(recibo_pago) AS longitud_recibo
FROM pago_suscriptor
WHERE DBMS_LOB.GETLENGTH(recibo_pago) > 0;

-- Validación para ARTICULO (Fragmentación Vertical)
PROMPT ====================================
PROMPT ARTICULO - Estrategia 1
PROMPT ====================================
SELECT articulo_id, DBMS_LOB.GETLENGTH(pdf) AS longitud_pdf
FROM articulo_e1
WHERE DBMS_LOB.GETLENGTH(pdf) > 0;

PROMPT ====================================
PROMPT ARTICULO - Estrategia 2
PROMPT ====================================
SELECT articulo_id, DBMS_LOB.GETLENGTH(pdf) AS longitud_pdf
FROM articulo_e2
WHERE DBMS_LOB.GETLENGTH(pdf) > 0;

PROMPT ====================================
PROMPT ARTICULO - Sinónimo (Estrategia 2)
PROMPT ====================================
SELECT articulo_id, DBMS_LOB.GETLENGTH(pdf) AS longitud_pdf
FROM articulo
WHERE DBMS_LOB.GETLENGTH(pdf) > 0;

-- =============================================
-- CONEXIÓN A SITIO 2 (sssbdd_s2)
-- =============================================
PROMPT Conectándose a sssbdd_s2;
CONNECT editorial_bdd/editorial_bdd@sssbdd_s2;

-- Validación para PAGO_SUSCRIPTOR (BLOB local)
PROMPT ====================================
PROMPT PAGO_SUSCRIPTOR - Vista Global
PROMPT ====================================
SELECT num_pago, DBMS_LOB.GETLENGTH(recibo_pago) AS longitud_recibo
FROM pago_suscriptor
WHERE DBMS_LOB.GETLENGTH(recibo_pago) > 0;

-- Validación para ARTICULO (BLOB local)
PROMPT ====================================
PROMPT ARTICULO - Vista Global
PROMPT ====================================
SELECT articulo_id, DBMS_LOB.GETLENGTH(pdf) AS longitud_pdf
FROM articulo
WHERE DBMS_LOB.GETLENGTH(pdf) > 0;

PROMPT ====================================
PROMPT Validación completada exitosamente!
PROMPT ====================================