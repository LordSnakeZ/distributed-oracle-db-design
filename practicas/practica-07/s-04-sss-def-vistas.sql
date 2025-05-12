--@Autor: Santiago Sanchez Sanchez
--@Fecha creación: 19/04/2025
--@Descripción: Definicion de Vistas en entidades sin Blob

CREATE OR REPLACE VIEW suscriptor AS
SELECT s.suscriptor_id, s.num_tarjeta, q1.nombre, q1.ap_paterno, q1.ap_materno, q1.fecha_inscripcion, q1.pais_id FROM suscriptor_1 s
JOIN (
    SELECT suscriptor_id, nombre, ap_paterno, ap_materno, fecha_inscripcion, pais_id FROM suscriptor_2
    UNION ALL
    SELECT suscriptor_id, nombre, ap_paterno, ap_materno, fecha_inscripcion, pais_id FROM suscriptor_3
    UNION ALL
    SELECT suscriptor_id, nombre, ap_paterno, ap_materno, fecha_inscripcion, pais_id FROM suscriptor_4
    ) q1
ON  s.suscriptor_id = q1.suscriptor_id;


CREATE OR REPLACE VIEW revista AS
SELECT revista_id, folio, titulo, fecha_publicacion, revista_adicional_id FROM revista_1
UNION ALL
SELECT revista_id, folio, titulo, fecha_publicacion, revista_adicional_id FROM revista_2;

CREATE OR REPLACE VIEW pais AS
SELECT pais_id, clave, nombre, region_economica FROM pais_1
UNION ALL
SELECT pais_id, clave, nombre, region_economica FROM pais_2;

CREATE OR REPLACE VIEW articulo_revista AS
SELECT articulo_revista_id, fecha_aprobacion, calificacion, revista_id, articulo_id FROM articulo_revista_1
UNION ALL
SELECT articulo_revista_id, fecha_aprobacion, calificacion, revista_id, articulo_id FROM articulo_revista_2;
