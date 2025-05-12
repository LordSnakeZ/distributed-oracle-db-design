CONNECT editorial_bdd/editorial_bdd@sssbdd_s1;

PROMPT Creando liga unidireccional de S1 a S2.
CREATE DATABASE LINK sssbdd_s2.fi.unam USING 'SSSBDD_S2';

PROMPT Creando liga unidireccional de S2 a S1.

CONNECT editorial_bdd/editorial_bdd@sssbdd_s2;
CREATE DATABASE LINK sssbdd_s1.fi.unam USING 'SSSBDD_S1';

PROMPT Finalizado!!!

EXIT


