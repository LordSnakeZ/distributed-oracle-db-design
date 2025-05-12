-- Sitio #1

CREATE TABLE F_SSS_SUSCRIPTOR_1 (
    suscriptor_id NUMBER(10),
    num_tarjeta VARCHAR2(15) NOT NULL,
    CONSTRAINT f_sss_suscriptor_1_pk PRIMARY KEY (suscriptor_id)
);

CREATE TABLE F_SSS_PAIS_1 (
    pais_id NUMBER(3),
    clave VARCHAR(3) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    region_economica CHAR(1) NOT NULL,
    CONSTRAINT f_sss_pais_1_pk PRIMARY KEY (pais_id)
);

CREATE TABLE F_SSS_SUSCRIPTOR_2 (
    suscriptor_id NUMBER(10),
    nombre VARCHAR2(40) NOT NULL,
    ap_paterno VARCHAR2(40) NOT NULL,
    ap_materno VARCHAR2(40),
    fecha_inscripcion VARCHAR2(40) NOT NULL,
    pais_id NUMBER(3),
    CONSTRAINT f_sss_suscriptor_2_pk PRIMARY KEY (suscriptor_id),
    CONSTRAINT f_sss_pais_1_pais_id_fk FOREIGN KEY (pais_id) REFERENCES F_SSS_PAIS_1 (pais_id)
);

CREATE TABLE F_SSS_SUSCRIPTOR_3 (
    suscriptor_id NUMBER(10),
    nombre VARCHAR2(40) NOT NULL,
    ap_paterno VARCHAR2(40) NOT NULL,
    ap_materno VARCHAR2(40),
    fecha_inscripcion VARCHAR2(40) NOT NULL,
    pais_id NUMBER(3),
    CONSTRAINT f_sss_suscriptor_3_pk PRIMARY KEY (suscriptor_id)
);

CREATE TABLE F_SSS_REVISTA_1 (
    revista_id NUMBER(10) NOT NULL,
    folio VARCHAR2(10) NOT NULL,
    titulo VARCHAR2(40) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    revista_adicional_id NUMBER(10) NULL,
    CONSTRAINT f_sss_revista_1_pk PRIMARY KEY (revista_id)
);

CREATE TABLE F_SSS_ARTICULO_2 (
    articulo_id NUMBER(10),
    titulo VARCHAR2(40) NOT NULL,
    resumen VARCHAR2(500) NOT NULL,
    texto VARCHAR2(4000) NOT NULL,
    CONSTRAINT f_sss_articulo_2_pk PRIMARY KEY (articulo_id)
);

DROP TABLE F_SSS_ARTICULO_REVISTA_1;

CREATE TABLE F_SSS_ARTICULO_REVISTA_1 (
    articulo_revista_id VARCHAR2(40),
    fecha_aprobacion VARCHAR2(40) NOT NULL,
    calificacion VARCHAR2(40) NOT NULL,
    revista_id NUMBER(10) NOT NULL,
    articulo_id NUMBER(10) NOT NULL,
    CONSTRAINT f_sss_articulo_revista_1_pk PRIMARY KEY (articulo_revista_id),
    CONSTRAINT f_sss_revista_1_revista_id_fk FOREIGN KEY (revista_id) REFERENCES F_SSS_REVISTA_1 (revista_id),
    CONSTRAINT f_sss_articulo_2_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES F_SSS_ARTICULO_2 (articulo_id)
);

CREATE TABLE F_SSS_PAGO_SUSCRIPTOR_1 (
    num_pago NUMBER(10, 0),
    suscriptor_id NUMBER(10, 0),
    fecha_pago DATE NOT NULL,
    importe NUMBER(8, 2),
    recibo_pago BLOB NOT NULL,
    CONSTRAINT f_sss_pago_suscriptor_1_pk PRIMARY KEY (num_pago),
    CONSTRAINT f_sss_suscriptor_1_suscriptor_id_fk FOREIGN KEY (suscriptor_id) REFERENCES F_SSS_SUSCRIPTOR_1 (suscriptor_id)
);
