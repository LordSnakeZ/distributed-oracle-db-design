--@Autor: Santiago Sanchez Sanchez
--@Fecha creación: 19/04/2025
--@Descripción: Script de ejecución para crear de vistas
-- en ambas PDBs

prompt conectándose a sssbdd_s1
connect editorial_bdd/editorial_bdd@sssbdd_s1
Prompt creando vistas en sssbdd_s1
@s-04-sss-def-vistas.sql
Prompt conectándose a sssbdd_s2
connect editorial_bdd/editorial_bdd@sssbdd_s2
Prompt creando vistas en sssbdd_s2
@s-04-sss-def-vistas.sql
Prompt Listo!
exit