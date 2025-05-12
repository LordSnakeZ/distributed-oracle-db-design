--@Autor: Santiago Sanchez Sanchez
--@Fecha creación: 19/04/2025
--@Descripción: Main para implementacion de localizacion

PROMPT Connecting S1
CONNECT editorial_bdd/editorial_bdd@sssbdd_s1;

set serveroutput on
start s-03-sss-consultas-localizacion.sql

PROMPT Connecting S2
CONNECT editorial_bdd/editorial_bdd@sssbdd_s2;

set serveroutput on
start s-03-sss-consultas-localizacion.sql

EXIT