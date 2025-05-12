
--@Autor:          Jorge A. Rodríguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción:     script de validación


whenever sqlerror exit rollback
set serveroutput on
set verify off

--Modificar las siguientes  variables en caso de ser necesario.
--En scripts reales no deben incluirse passwords. Solo se hace para
--propósitos de pruebas y evitar escribirlos cada vez que se quiera ejecutar 
--el proceso de validación de la práctica (propósitos académicos).

--
-- Nombre del usuario empleado en esta práctica
--
define p_usuario='editorial_bdd'

--
-- Password del usuario empleado en esta práctica
--
define p_usuario_pass='editorial_bdd'

--
-- Nombre de la PDB 1
--
define p_pdb1='sssbdd_s1'

--
-- Nombre de la PDB 2
--
define p_pdb2='sssbdd_s2'

--
-- Iniciales empleadas para nombrar fragmentos Ejemplo JRC
--
define p_iniciales='SSS'

---
--- Elección de fragmentación para SUCURSAL: 
---  A  Con respecto a Articulo (default)
---  R  Con respecto a Revista   
---
define p_tipo_fr='R'

--- ============= Las siguientes configuraciones ya no requieren cambiarse====

whenever sqlerror exit rollback
set verify off
set feedback off

Prompt =========================================================
Prompt Iniciando validador - Práctica 5
Prompt Los valores que aparecen entre [] son los valores que se toman
Prompt por defecto. Se puede presionar Enter en caso de no desear modificar su valor.
Prompt =========================================================


accept p_usuario default '&&p_usuario' prompt '1. Proporcionar el nombre de usuario [&&p_usuario]: '
accept p_usuario_pwd default '&&p_usuario_pass' prompt '2. Proporcionar password del usuario &&p_usuario_pass [configurado en script]: ' hide
accept p_pdb1 default '&&p_pdb1' prompt '3. Nombre del sitio 1 [&&p_pdb1]: '
accept p_pdb2 default '&&p_pdb2' prompt '4. Nombre del sitio 2 [&&p_pdb2]: '
accept p_iniciales default '&&p_iniciales' prompt '5. Iniciales empleadas para nombrar fragmentos [&&p_iniciales]: '
Prompt 6. Indicar la estrategia de fragmentación para la tabla SUCURSAL:
prompt    A - Con respecto a Articulo (default)
Prompt    R - Con respecto a Revista
accept p_tipo_fr default '&&p_tipo_fr' prompt 'Indicar valor [&&p_tipo_fr]: '

define p_script_validador='sv-08p-validacion-pdb-create.plb'

--crea Objetos
start &&p_script_validador &&p_pdb1 &&p_usuario &&p_usuario_pass &&p_tipo_fr 1
start &&p_script_validador &&p_pdb2 &&p_usuario &&p_usuario_pass &&p_tipo_fr 2
--ejecuta procedimientos

exec spv_print_header
host sha256sum &&p_script_validador

start sv-08-validacion-pdb-execute.sql &&p_pdb1 &&p_usuario &&p_usuario_pass &&p_tipo_fr 1 &&p_iniciales
start sv-08-validacion-pdb-execute.sql &&p_pdb2 &&p_usuario &&p_usuario_pass &&p_tipo_fr 2 &&p_iniciales

Prompt Listo!.
exit
