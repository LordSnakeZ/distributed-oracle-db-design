-- Manejo de errores
WHENEVER SQLERROR EXIT ROLLBACK;

Prompt Conectando a S1
connect editorial_bdd/editorial_bdd@sssbdd_s1;

-- Limpiar tablas en S1
DELETE FROM F_SSS_SUSCRIPTOR_2;
DELETE FROM F_SSS_SUSCRIPTOR_3;
DELETE FROM F_SSS_ARTICULO_REVISTA_1;
DELETE FROM F_SSS_REVISTA_1;
DELETE FROM F_SSS_ARTICULO_2;
DELETE FROM F_SSS_PAGO_SUSCRIPTOR_1;
DELETE FROM F_SSS_SUSCRIPTOR_1;
DELETE FROM F_SSS_PAIS_1;

INSERT INTO F_SSS_PAIS_1 (
    pais_id,
    clave,
    nombre,
    region_economica
)
VALUES (
    1,
    'MX',
    'MEXICO',
    'A'
);

INSERT INTO F_SSS_SUSCRIPTOR_1 (
    suscriptor_id,
    num_tarjeta
)
VALUES
    (1, '542090075402872'),
    (2, '580080797630152'),
    (3, '620287012903602');

INSERT INTO F_SSS_SUSCRIPTOR_2 (
    suscriptor_id,
    nombre,
    ap_paterno,
    ap_materno,
    fecha_inscripcion,
    pais_id
)
VALUES (
    1,
    'OMAR',
    'LOPEZ',
    'MENDEZ',
    '01/01/2017',
    1
);

INSERT INTO F_SSS_SUSCRIPTOR_3 (
    suscriptor_id,
    nombre,
    ap_paterno,
    ap_materno,
    fecha_inscripcion,
    pais_id
)
VALUES (
    2,
    'LALO',
    'KIM',
    'LUNA',
    '01/01/2016',
    2
);

INSERT INTO F_SSS_ARTICULO_2 (
    articulo_id,
    titulo,
    resumen,
    texto
)
VALUES
    (1, 'LOS SISMOS', 'Estudio y origen de los sismos', 'Texto de ejemplo para el artículo'),
    (2, 'FAUNA MARINA', 'Estudio de la fauna marina de México', 'Texto de ejemplo para el artículo');

INSERT INTO F_SSS_REVISTA_1 (
   revista_id,
   folio,
   titulo,
   fecha_publicacion,
   revista_adicional_id
)
 VALUES (
    1,
    '90001',
    'Premier',
    TO_DATE('01/03/2017', 'DD/MM/YYYY'),
    null
);

INSERT INTO F_SSS_ARTICULO_REVISTA_1 (
   articulo_revista_id,
   articulo_id,
   revista_id,
   fecha_aprobacion,
   calificacion
)
VALUES (
    '1',
    1,
    1,
    '01/02/2017',
    '9'
);
prompt 'lo ultimo es F_SSS_ARTICULO_REVISTA_1'

INSERT INTO F_SSS_PAGO_SUSCRIPTOR_1 (
    num_pago,
    suscriptor_id,
    fecha_pago,
    importe,
    recibo_pago
)
VALUES (
    1,
    1,
    TO_DATE('01/02/2017', 'DD/MM/YYYY'),
    989.67,
    EMPTY_BLOB()
);

COMMIT;

Prompt Conectando a S2
connect editorial_bdd/editorial_bdd@sssbdd_s2;

-- Limpiar tablas en S2
DELETE FROM F_SSS_SUSCRIPTOR_4;
DELETE FROM F_SSS_ARTICULO_REVISTA_2;
DELETE FROM F_SSS_REVISTA_2;
DELETE FROM F_SSS_ARTICULO_1;
DELETE FROM F_SSS_PAGO_SUSCRIPTOR_2;
DELETE FROM F_SSS_PAIS_2;

INSERT INTO F_SSS_PAIS_2 (
    pais_id,
    clave,
    nombre,
    region_economica
)
VALUES (
    2,
    'JAP',
    'JAPON',
    'B'
);

INSERT INTO F_SSS_SUSCRIPTOR_4 (
    suscriptor_id,
    nombre,
    ap_paterno,
    ap_materno,
    fecha_inscripcion,
    pais_id
)
VALUES (
    3,
    'LUCY',
    'ZAMORA',
    'PEREZ',
    '01/01/2015',
    2
);

INSERT INTO F_SSS_ARTICULO_1 (
    articulo_id,
    pdf
)
VALUES
    (1, EMPTY_BLOB()),
    (2, EMPTY_BLOB());


INSERT INTO F_SSS_REVISTA_2 (
   revista_id,
   folio,
   titulo,
   fecha_publicacion,
   revista_adicional_id
)
 VALUES (
    2,
    '90002',
    'TI en la UNAM',
    TO_DATE('01/09/2017', 'DD/MM/YYYY'),
    1
);

INSERT INTO F_SSS_ARTICULO_REVISTA_2 (
   articulo_revista_id,
   articulo_id,
   revista_id,
   fecha_aprobacion,
   calificacion
)
VALUES (
    '2',
    2,
    2,
    '01/08/2017',
    '10'
);

INSERT INTO F_SSS_PAGO_SUSCRIPTOR_2 (
    num_pago,
    suscriptor_id,
    fecha_pago,
    importe,
    recibo_pago
)
VALUES (
    70,
    2,
    TO_DATE('01/08/2017', 'DD/MM/YYYY'),
    1000.55,
    EMPTY_BLOB()
);

COMMIT;

Prompt Listo!
EXIT;
