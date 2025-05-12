-- @Autor: Santiago Sanchez Sanchez
-- @Descripción: Implementación final corregida para SITIO1
connect editorial_bdd/editorial_bdd@sssbdd_s1;

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

-- 2. Tabla temporal
CREATE GLOBAL TEMPORARY TABLE t_pago_suscriptor_remoto (
  num_pago NUMBER(10,0) PRIMARY KEY,
  suscriptor_id NUMBER(10,0) NOT NULL,
  fecha_pago DATE NOT NULL,
  importe NUMBER(8,2) NOT NULL,
  recibo_pago BLOB NOT NULL
) ON COMMIT PRESERVE ROWS;

-- 3. Función para estrategia 1
CREATE OR REPLACE FUNCTION get_remote_pagos_blobs
RETURN pago_suscriptor_blob_table PIPELINED IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  DELETE FROM t_pago_suscriptor_remoto;
  
  INSERT INTO t_pago_suscriptor_remoto 
  SELECT num_pago, suscriptor_id, fecha_pago, importe, recibo_pago
  FROM pago_suscriptor_2;
  
  COMMIT;
  
  FOR cur IN (SELECT * FROM t_pago_suscriptor_remoto) LOOP
    PIPE ROW(pago_suscriptor_blob_type(
      cur.num_pago, cur.suscriptor_id, cur.fecha_pago, 
      cur.importe, cur.recibo_pago));
  END LOOP;
  
  DELETE FROM t_pago_suscriptor_remoto;
  COMMIT;
  RETURN;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

-- 4. Función para estrategia 2
CREATE OR REPLACE FUNCTION get_remote_pago_blob_by_id(
  p_num_pago IN NUMBER
) RETURN BLOB IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  v_blob BLOB;
BEGIN
  DELETE FROM t_pago_suscriptor_remoto;
  
  INSERT INTO t_pago_suscriptor_remoto 
  SELECT * FROM pago_suscriptor_2
  WHERE num_pago = p_num_pago;
  
  SELECT recibo_pago INTO v_blob
  FROM t_pago_suscriptor_remoto
  WHERE num_pago = p_num_pago;
  
  DELETE FROM t_pago_suscriptor_remoto;
  COMMIT;
  RETURN v_blob;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

-- CONFIGURACIÓN PARA ARTICULO (Fragmentación Vertical)
-- ----------------------------------------------------

CREATE OR REPLACE TYPE articulo_blob_type AS OBJECT (
  articulo_id NUMBER(10,0),
  pdf BLOB
);
/

CREATE OR REPLACE TYPE articulo_blob_table AS TABLE OF articulo_blob_type;
/

CREATE GLOBAL TEMPORARY TABLE t_articulo_remoto (
  articulo_id NUMBER(10,0) PRIMARY KEY,
  pdf BLOB NOT NULL
) ON COMMIT PRESERVE ROWS;

CREATE OR REPLACE FUNCTION get_remote_articulos_blobs
RETURN articulo_blob_table PIPELINED IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  DELETE FROM t_articulo_remoto;
  
  INSERT INTO t_articulo_remoto 
  SELECT articulo_id, pdf FROM articulo_1;
  
  COMMIT;
  
  FOR cur IN (SELECT * FROM t_articulo_remoto) LOOP
    PIPE ROW(articulo_blob_type(cur.articulo_id, cur.pdf));
  END LOOP;
  
  DELETE FROM t_articulo_remoto;
  COMMIT;
  RETURN;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

CREATE OR REPLACE FUNCTION get_remote_articulo_blob_by_id(
  p_articulo_id IN NUMBER
) RETURN BLOB IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  v_blob BLOB;
BEGIN
  DELETE FROM t_articulo_remoto;
  
  INSERT INTO t_articulo_remoto 
  SELECT articulo_id, pdf FROM articulo_1
  WHERE articulo_id = p_articulo_id;
  
  SELECT pdf INTO v_blob
  FROM t_articulo_remoto
  WHERE articulo_id = p_articulo_id;
  
  DELETE FROM t_articulo_remoto;
  COMMIT;
  RETURN v_blob;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/

-- VISTAS FINALES CON SINÓNIMOS CORRECTOS
-- -------------------------------------

-- PAGO_SUSCRIPTOR Estrategia 1
CREATE OR REPLACE VIEW pago_suscriptor_e1 AS
SELECT * FROM pago_suscriptor_1
UNION ALL
SELECT * FROM TABLE(get_remote_pagos_blobs);

-- PAGO_SUSCRIPTOR Estrategia 2
CREATE OR REPLACE VIEW pago_suscriptor_e2 AS
SELECT * FROM pago_suscriptor_1
UNION ALL
SELECT num_pago, suscriptor_id, fecha_pago, importe, 
       get_remote_pago_blob_by_id(num_pago) AS recibo_pago
FROM pago_suscriptor_2;

-- ARTICULO Estrategia 1
CREATE OR REPLACE VIEW articulo_e1 AS
SELECT a.articulo_id, a.titulo, a.resumen, a.texto, b.pdf
FROM articulo_2 a
JOIN TABLE(get_remote_articulos_blobs) b
ON a.articulo_id = b.articulo_id;

-- ARTICULO Estrategia 2
CREATE OR REPLACE VIEW articulo_e2 AS
SELECT a.articulo_id, a.titulo, a.resumen, a.texto,
       get_remote_articulo_blob_by_id(a.articulo_id) AS pdf
FROM articulo_2 a;

-- SINÓNIMOS PRINCIPALES
CREATE OR REPLACE SYNONYM pago_suscriptor FOR pago_suscriptor_e2;
CREATE OR REPLACE SYNONYM articulo FOR articulo_e2;

COMMIT;