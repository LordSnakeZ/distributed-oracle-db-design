-- Conectar al primer PDB

connect editorial_bdd/editorial_bdd@sssbdd_s1;
@/unam/bdd/practicas/practica-05/s-02-sss-sssbdd_s1-ddl.sql

-- Conectar al segundo PDB
connect editorial_bdd/editorial_bdd@sssbdd_s2;
@/unam/bdd/practicas/practica-05/s-02-sss-sssbdd_s2-ddl.sql

-- Confirmar la ejecución
COMMIT;
