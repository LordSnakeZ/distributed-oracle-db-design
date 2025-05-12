--@Autor: Santiago Sánchez Sánchez
--@Fecha creación: 23/03/2025
--@Descripción: Consulta de restricciones de referencia en jrc-pc
Prompt Conectando a S1 - sssbdd_s1
connect editorial_bdd/editorial_bdd@sssbdd_s1
--ejecuta la misma consulta en ambas pdbs
@s-05-sss-consulta-restricciones.sql

Prompt Conectando a S2 - sssbdd_s2
connect editorial_bdd/editorial_bdd@sssbdd_s1
--ejecuta la misma consulta en ambas pdbs
@s-05-sss-consulta-restricciones.sql

Prompt Listo!
exit
