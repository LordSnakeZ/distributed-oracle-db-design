--@Autor: Santiago Sánchez Sánchez
--@Fecha creación: 23/03/2025
--@Descripción: Consulta de restricciones de referencia

Prompt mostrando lista de restricciones de referencia

col tabla_padre format A30
col tabla_hija format A30
col nombre_restriccion format A30
set linesize 200

select th.table_name tabla_hija, th.constraint_name nombre_restriccion,
tp.table_name tabla_padre, th.constraint_type tipo_constraint
from user_constraints th, user_constraints tp
where th.constraint_type='R'
and th.r_constraint_name=tp.constraint_name
order by tabla_padre;
