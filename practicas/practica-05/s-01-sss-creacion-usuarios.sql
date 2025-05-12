--@Autor: Santiago Sánchez Sánchez
--@Fecha creación: 21/03/2025
--@Descripción: Creación de usuarios para la máquina pc-sss.

connect sys/302405@sssbdd_s1 as sysdba;

create user editorial_bdd identified by editorial_bdd quota unlimited on users;

grant create table, create session, create procedure, create sequence to editorial_bdd;

connect sys/302405@sssbdd_s2 as sysdba;

create user editorial_bdd identified by editorial_bdd quota unlimited on users;

grant create table, create session, create procedure, create sequence to editorial_bdd;

exit

