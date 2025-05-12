--@Autor: Santiago Sánchez Sánchez
--@Fecha creación: 28/03/2025
--@Descripción: Carga y Export de archivos PDF

whenever sqlerror exit rollback;

--ruta donde se ubicarán los archivos PDFs
define p_pdf_path='/unam/bdd/practicas/practica-06/pdf'
set verify off

Prompt cambiando permisos a archivos PDF
!chmod 755 &p_pdf_path/m_archivo_*.pdf

Prompt cambiando permisos a la carpeta pdf
!chmod 777 &p_pdf_path

--Actividades en sssbdd_s1
Prompt conectando a sssbdd_s1 como SYS para crear objetos tipo directory
connect sys/302405@sssbdd_s1 as sysdba;

Prompt creando un objeto DIRECTORY para acceder al directorio &p_pdf_path
create or replace directory tmp_dir as '&p_pdf_path';
grant read,write on directory tmp_dir to editorial_bdd;

--Actividades en sssbdd_s2
Prompt conectando a sssbdd_s2 como SYS para crear objetos tipo directory
connect sys/302405@sssbdd_s2 as sysdba;

Prompt creando un objeto DIRECTORY para acceder al directorio &p_pdf_path
create or replace directory tmp_dir as '&p_pdf_path';
grant read,write on directory tmp_dir to editorial_bdd;

------------------ Cargando datos en sssbdd_s1 ----------------------
Prompt conectando a sssbdd_s1 con usuario editorial_bdd para cargar datos binarios
connect editorial_bdd/editorial_bdd@sssbdd_s1
/*
En este sitio se cargarán los siguientes archivos.
F_SSS_PAGO_SUSCRIPTOR_1
NUM_PAGO SUSCRIPTOR_ID RECIBO_PAGO
--------- ------------- ----------
1 1 m_archivo_3.pdf
*/
Prompt ejecutando procedimientos para hacer import/export de datos BLOB
@s-00-carga-blob-en-bd.sql
@s-00-guarda-blob-en-archivo.sql

Prompt cargando datos binarios en sssbdd_s1
begin
  carga_blob_en_bd('TMP_DIR','m_archivo_3.pdf','f_sss_pago_suscriptor_1',
    'recibo_pago','num_pago','1','suscriptor_id','1');
  commit;
end;
/

Prompt mostrando el tamaño de los objetos BLOB en BD.
Prompt para f_sss_pago_suscriptor_1:
select num_pago,suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from f_sss_pago_suscriptor_1;

Prompt salvando datos BLOB en directorio TMP_DIR
begin
  guarda_blob_en_archivo('TMP_DIR','m_export_archivo_3.pdf',
    'f_sss_pago_suscriptor_1','recibo_pago','num_pago','1','suscriptor_id','1');
end;
/

Prompt mostrando el contenido del directorio para validar la existencia del archivo.
!ls -l &p_pdf_path/m_archivo_*.pdf

------------------ Cargando datos en sssbdd_s2 ----------------------
Prompt conectando a sssbdd_s2 con usuario editorial_bdd para cargar datos binarios
connect editorial_bdd/editorial_bdd@sssbdd_s2

Prompt ejecutando procedimientos para hacer import/export de datos BLOB
@s-00-carga-blob-en-bd.sql
@s-00-guarda-blob-en-archivo.sql

Prompt cargando datos binarios en sssbdd_s2
begin
  carga_blob_en_bd('TMP_DIR','m_archivo_4.pdf','f_sss_pago_suscriptor_2',
    'recibo_pago','num_pago','70','suscriptor_id','2');
  carga_blob_en_bd('TMP_DIR','m_archivo_1.pdf','f_sss_articulo_1',
    'pdf','articulo_id','1','articulo_id','1');
  carga_blob_en_bd('TMP_DIR','m_archivo_2.pdf','f_sss_articulo_1',
    'pdf','articulo_id','2','articulo_id','2');
  commit;
end;
/

Prompt mostrando el tamaño de los objetos BLOB en BD.
Prompt para f_sss_pago_suscriptor_2:
select num_pago,suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from f_sss_pago_suscriptor_2;

SELECT articulo_id, dbms_lob.getlength(pdf) as longitud2
FROM f_sss_articulo_1;

Prompt salvando datos BLOB en directorio TMP_DIR
begin
  guarda_blob_en_archivo('TMP_DIR','m_export_archivo_4.pdf',
    'f_sss_pago_suscriptor_2','recibo_pago','num_pago','70','suscriptor_id','2');
  guarda_blob_en_archivo('TMP_DIR','m_export_archivo_1.pdf',
    'f_sss_articulo_1','pdf','articulo_id','1','articulo_id','1');
  guarda_blob_en_archivo('TMP_DIR','m_export_archivo_2.pdf',
    'f_sss_articulo_1','pdf','articulo_id','2','articulo_id','2');
end;
/

Prompt mostrando el contenido del directorio para validar la existencia del archivo.
!ls -l &p_pdf_path/m_archivo_*.pdf
