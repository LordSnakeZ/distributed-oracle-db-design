--@Autor: Santiago Sanchez Sanchez
--@Fecha creación: 19/04/2025
--@Descripción: Creación de sinónimos

-- Work for First PDB: S1
CONNECT editorial_bdd/editorial_bdd@sssbdd_s1;

PROMPT Creating synonyms for S1;

CREATE OR REPLACE SYNONYM suscriptor_1 FOR f_sss_suscriptor_1;
CREATE OR REPLACE SYNONYM suscriptor_2 FOR f_sss_suscriptor_2;
CREATE OR REPLACE SYNONYM suscriptor_3 FOR f_sss_suscriptor_3;
CREATE OR REPLACE SYNONYM suscriptor_4 FOR f_sss_suscriptor_4@sssbdd_s2.fi.unam;
CREATE OR REPLACE SYNONYM pais_1 FOR f_sss_pais_1;
CREATE OR REPLACE SYNONYM pais_2 FOR f_sss_pais_2@sssbdd_s2.fi.unam;
CREATE OR REPLACE SYNONYM revista_1 FOR f_sss_revista_1;
CREATE OR REPLACE SYNONYM revista_2 FOR f_sss_revista_2@sssbdd_s2.fi.unam;
CREATE OR REPLACE SYNONYM articulo_2 FOR f_sss_articulo_2;
CREATE OR REPLACE SYNONYM articulo_1 FOR f_sss_articulo_1@sssbdd_s2.fi.unam;
CREATE OR REPLACE SYNONYM pago_suscriptor_1 FOR f_sss_pago_suscriptor_1;
CREATE OR REPLACE SYNONYM pago_suscriptor_2 FOR f_sss_pago_suscriptor_2@sssbdd_s2.fi.unam;
CREATE OR REPLACE SYNONYM articulo_revista_1 FOR f_sss_articulo_revista_1;
CREATE OR REPLACE SYNONYM articulo_revista_2 FOR f_sss_articulo_revista_2@sssbdd_s2.fi.unam;

-- Work for First PDB: S2
CONNECT editorial_bdd/editorial_bdd@sssbdd_s2;

PROMPT Creating synonyms for S2;

CREATE OR REPLACE SYNONYM suscriptor_1 FOR f_sss_suscriptor_1@sssbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM suscriptor_2 FOR f_sss_suscriptor_2@sssbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM suscriptor_3 FOR f_sss_suscriptor_3@sssbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM suscriptor_4 FOR f_sss_suscriptor_4;
CREATE OR REPLACE SYNONYM pais_1 FOR f_sss_pais_1@sssbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM pais_2 FOR f_sss_pais_2;
CREATE OR REPLACE SYNONYM revista_1 FOR f_sss_revista_1@sssbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM revista_2 FOR f_sss_revista_2;
CREATE OR REPLACE SYNONYM articulo_2 FOR f_sss_articulo_2@sssbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM articulo_1 FOR f_sss_articulo_1;
CREATE OR REPLACE SYNONYM pago_suscriptor_1 FOR f_sss_pago_suscriptor_1@sssbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM pago_suscriptor_2 FOR f_sss_pago_suscriptor_2;
CREATE OR REPLACE SYNONYM articulo_revista_1 FOR f_sss_articulo_revista_1@sssbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM articulo_revista_2 FOR f_sss_articulo_revista_2;

EXIT