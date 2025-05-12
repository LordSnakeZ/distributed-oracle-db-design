-- @Autor: Santiago Sánchez Sánchez
-- @Fecha creación: 23/03/2025
-- @Descripción: Consulta de fragmentos creados en sss-pc

Prompt Conectando a S1 - sssbdd_s1
connect editorial_bdd/editorial_bdd@sssbdd_s1;
Prompt mostrando lista de fragmentos
col table_name format a30
select table_name from user_tables order by table_name;

Prompt Conectando a S2 - sssbdd_s2
connect editorial_bdd/editorial_bdd@sssbdd_s2;
Prompt mostrando lista de fragmentos
col table_name format a30
select table_name from user_tables order by table_name;

Prompt Listo!
