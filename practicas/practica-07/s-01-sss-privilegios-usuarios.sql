--@Autor: Santiago Sanchez Sanchez
--@Fecha creación: 19/04/2025
--@Descripción: Administracion de Privilegios

-- Work for First PDB: S1
CONNECT sys/302405@sssbdd_s1 as sysdba;

GRANT CREATE SYNONYM, CREATE VIEW, CREATE TYPE, CREATE PROCEDURE TO editorial_bdd;



-- Work for Second PDB: S2
CONNECT sys/302405@sssbdd_s2 as sysdba;

GRANT CREATE SYNONYM, CREATE VIEW, CREATE TYPE, CREATE PROCEDURE TO editorial_bdd;

EXIT