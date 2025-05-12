-- @Autor: Santiago Sanchez Sanchez
-- @Descripción: Implementación definitiva optimizada para SITIO2 con ARTICULO_E2 y PAGO_SUSCRIPTOR_E2
connect editorial_bdd/editorial_bdd@sssbdd_s2;

-- Bloque de limpieza mejorado que maneja todas las dependencias
BEGIN
  -- Eliminar sinónimos primero
  BEGIN
    EXECUTE IMMEDIATE 'DROP SYNONYM pago_suscriptor';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP SYNONYM articulo';
  EXCEPTION WHEN OTHERS THEN NULL; END;

  -- Eliminar vistas
  BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW pago_suscriptor_e2';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW pago_suscriptor_e1';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW articulo_e2';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW articulo_e1';
  EXCEPTION WHEN OTHERS THEN NULL; END;

  -- Eliminar funciones
  BEGIN
    EXECUTE IMMEDIATE 'DROP FUNCTION get_remote_pago_blob_by_id';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP FUNCTION get_remote_pagos_blobs';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP FUNCTION get_remote_articulo_data';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP FUNCTION get_remote_articulos_data';
  EXCEPTION WHEN OTHERS THEN NULL; END;

  -- Eliminar tablas temporales
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE t_pago_suscriptor_remoto PURGE';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE t_articulo_remoto PURGE';
  EXCEPTION WHEN OTHERS THEN NULL; END;

  -- Eliminar tipos
  BEGIN
    EXECUTE IMMEDIATE 'DROP TYPE pago_suscriptor_blob_table FORCE';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP TYPE pago_suscriptor_blob_type FORCE';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP TYPE articulo_blob_table FORCE';
  EXCEPTION WHEN OTHERS THEN NULL; END;
  
  BEGIN
    EXECUTE IMMEDIATE 'DROP TYPE articulo_blob_type FORCE';
  EXCEPTION WHEN OTHERS THEN NULL; END;
END;
/

-- CONFIGURACIÓN PARA ARTICULO (Fragmentación Vertical)
-- ----------------------------------------------------

-- 1. Tipo de objeto para el fragmento remoto
CREATE OR REPLACE TYPE articulo_blob_type AS OBJECT (
  articulo_id NUMBER(10,0),
  titulo VARCHAR2(40),
  resumen VARCHAR2(40),
  texto VARCHAR2(40)
);
/

CREATE OR REPLACE TYPE articulo_blob_table AS TABLE OF articulo_blob_type;
/

-- 2. Tabla temporal para datos remotos
CREATE GLOBAL TEMPORARY TABLE t_articulo_remoto (
  articulo_id NUMBER(10,0) PRIMARY KEY,
  titulo VARCHAR2(40) NOT NULL,
  resumen VARCHAR2(40) NOT NULL,
  texto VARCHAR2(40) NOT NULL
) ON COMMIT PRESERVE ROWS;

-- 3. Función para estrategia 1 (trae todos los registros)
CREATE OR REPLACE FUNCTION get_remote_articulos_data
RETURN articulo_blob_table PIPELINED IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  -- Limpiar tabla temporal
  DELETE FROM t_articulo_remoto;
  
  -- Obtener datos remotos
  INSERT INTO t_articulo_remoto 
  SELECT articulo_id, titulo, resumen, texto
  FROM articulo_2;
  
  COMMIT;
  
  -- Pipe rows desde la tabla temporal
  FOR cur IN (SELECT * FROM t_articulo_remoto) LOOP
    PIPE ROW(articulo_blob_type(
      cur.articulo_id, cur.titulo, cur.resumen, cur.texto));
  END LOOP;
  
  -- Limpiar tabla temporal
  DELETE FROM t_articulo_remoto;
  COMMIT;
  RETURN;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

-- 4. Función para estrategia 2 (trae un registro específico)
CREATE OR REPLACE FUNCTION get_remote_articulo_data(
  p_articulo_id IN NUMBER
) RETURN articulo_blob_type IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  v_result articulo_blob_type;
BEGIN
  SELECT articulo_blob_type(articulo_id, titulo, resumen, texto)
  INTO v_result
  FROM articulo_2
  WHERE articulo_id = p_articulo_id;
  
  RETURN v_result;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

-- CONFIGURACIÓN PARA PAGO_SUSCRIPTOR (Fragmentación Horizontal)
-- ------------------------------------------------------------

-- 1. Tipo de objeto para el fragmento remoto
CREATE OR REPLACE TYPE pago_suscriptor_blob_type AS OBJECT (
  num_pago NUMBER(10,0),
  suscriptor_id NUMBER(10,0),
  fecha_pago DATE,
  importe NUMBER(8,2),
  recibo_pago BLOB
);
/

CREATE OR REPLACE TYPE pago_suscriptor_blob_table AS TABLE OF pago_suscriptor_blob_type;
/

-- 2. Tabla temporal para datos remotos
CREATE GLOBAL TEMPORARY TABLE t_pago_suscriptor_remoto (
  num_pago NUMBER(10,0) PRIMARY KEY,
  suscriptor_id NUMBER(10,0) NOT NULL,
  fecha_pago DATE NOT NULL,
  importe NUMBER(8,2) NOT NULL,
  recibo_pago BLOB NOT NULL
) ON COMMIT PRESERVE ROWS;

-- 3. Función para estrategia 1 (trae todos los registros)
CREATE OR REPLACE FUNCTION get_remote_pagos_blobs
RETURN pago_suscriptor_blob_table PIPELINED IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  -- Limpiar tabla temporal
  DELETE FROM t_pago_suscriptor_remoto;
  
  -- Obtener datos remotos
  INSERT INTO t_pago_suscriptor_remoto 
  SELECT num_pago, suscriptor_id, fecha_pago, importe, recibo_pago
  FROM pago_suscriptor_1;
  
  COMMIT;
  
  -- Pipe rows desde la tabla temporal
  FOR cur IN (SELECT * FROM t_pago_suscriptor_remoto) LOOP
    PIPE ROW(pago_suscriptor_blob_type(
      cur.num_pago, cur.suscriptor_id, cur.fecha_pago, 
      cur.importe, cur.recibo_pago));
  END LOOP;
  
  -- Limpiar tabla temporal
  DELETE FROM t_pago_suscriptor_remoto;
  COMMIT;
  RETURN;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

-- 4. Función para estrategia 2 (trae un blob específico)
CREATE OR REPLACE FUNCTION get_remote_pago_blob_by_id(
  p_num_pago IN NUMBER
) RETURN BLOB IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  v_blob BLOB;
BEGIN
  -- Limpiar tabla temporal
  DELETE FROM t_pago_suscriptor_remoto;
  
  -- Obtener blob remoto
  INSERT INTO t_pago_suscriptor_remoto 
  SELECT num_pago, suscriptor_id, fecha_pago, importe, recibo_pago
  FROM pago_suscriptor_1
  WHERE num_pago = p_num_pago;
  
  -- Extraer blob
  SELECT recibo_pago INTO v_blob
  FROM t_pago_suscriptor_remoto
  WHERE num_pago = p_num_pago;
  
  -- Limpiar tabla temporal
  DELETE FROM t_pago_suscriptor_remoto;
  COMMIT;
  
  RETURN v_blob;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

-- VISTAS FINALES OPTIMIZADAS
-- ----------------------------

-- ARTICULO 
CREATE OR REPLACE VIEW articulo AS
    SELECT
        q2.articulo_id,
        q2.titulo,
        q2.resumen,
        q2.texto,
        q1.pdf
    FROM articulo_1 q1
    JOIN articulo_2 q2
    ON q1.articulo_id = q2.articulo_id;

-- PAGO_SUSCRIPTOR Estrategia 1 (para consultas que necesitan todos los registros)
CREATE OR REPLACE VIEW pago_suscriptor_e1 AS
SELECT * FROM pago_suscriptor_2
UNION ALL
SELECT * FROM TABLE(get_remote_pagos_blobs);

-- PAGO_SUSCRIPTOR Estrategia 2 (optimizada para consultas por ID)
CREATE OR REPLACE VIEW pago_suscriptor_e2 AS
SELECT * FROM pago_suscriptor_2
UNION ALL
SELECT num_pago, suscriptor_id, fecha_pago, importe, 
       get_remote_pago_blob_by_id(num_pago) AS recibo_pago
FROM pago_suscriptor_1;

-- SINÓNIMOS PRINCIPALES (usando estrategia 2 por defecto)
CREATE OR REPLACE SYNONYM pago_suscriptor FOR pago_suscriptor_e2;

COMMIT;

PROMPT Implementación completada exitosamente!