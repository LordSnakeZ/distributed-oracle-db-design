-- Sitio #2

CREATE TABLE F_SSS_PAIS_2 (
    pais_id NUMBER(3, 0),
    clave VARCHAR(3) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    region_economica CHAR(1) NOT NULL,
    CONSTRAINT f_sss_pais_2_pk PRIMARY KEY (pais_id)
);

CREATE TABLE F_SSS_SUSCRIPTOR_4 (
    suscriptor_id NUMBER(10, 0),
    nombre VARCHAR2(40) NOT NULL,
    ap_paterno VARCHAR2(40) NOT NULL,
    ap_materno VARCHAR2(40),
    fecha_inscripcion VARCHAR2(40) NOT NULL,
    pais_id NUMBER(3, 0),
    CONSTRAINT f_sss_suscriptor_4_pk PRIMARY KEY (suscriptor_id),
    CONSTRAINT f_sss_pais_2_pais_id_fk FOREIGN KEY (pais_id) REFERENCES F_SSS_PAIS_2 (pais_id)
);

CREATE TABLE F_SSS_REVISTA_2 (
    revista_id NUMBER(10, 0) NOT NULL,
    folio VARCHAR2(10) NOT NULL,
    titulo VARCHAR2(40) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    revista_adicional_id NUMBER(10, 0) NULL,
    CONSTRAINT f_sss_revista_2_pk PRIMARY KEY (revista_id)
);

drop table F_SSS_ARTICULO_REVISTA_2;

CREATE TABLE F_SSS_ARTICULO_REVISTA_2 (
    articulo_revista_id VARCHAR2(40),
    fecha_aprobacion VARCHAR2(40) NOT NULL,
    calificacion VARCHAR2(40) NOT NULL,
    revista_id NUMBER(10, 0),
    articulo_id NUMBER(10, 0),
    CONSTRAINT f_sss_articulo_revista_2_pk PRIMARY KEY (articulo_revista_id),
    CONSTRAINT f_sss_revista_2_revista_id_fk FOREIGN KEY (revista_id) REFERENCES F_SSS_REVISTA_2 (revista_id),
    CONSTRAINT f_sss_articulo_1_articulo_id_fk FOREIGN KEY (articulo_id) REFERENCES F_SSS_ARTICULO_1 (articulo_id)
);

CREATE TABLE F_SSS_ARTICULO_1 (
    articulo_id NUMBER(10, 0),
    pdf BLOB NOT NULL,
    CONSTRAINT f_sss_articulo_1_pk PRIMARY KEY (articulo_id)
);

CREATE TABLE F_SSS_PAGO_SUSCRIPTOR_2 (
    num_pago NUMBER(10, 0),
    suscriptor_id NUMBER(10, 0),
    fecha_pago DATE NOT NULL,
    importe NUMBER(8, 2),
    recibo_pago BLOB NOT NULL,
    CONSTRAINT f_sss_pago_suscriptor_2_pk PRIMARY KEY (num_pago)
--    CONSTRAINT f_sss_pago_suscriptor_2_pk2 PRIMARY KEY (suscriptor_id)
);
