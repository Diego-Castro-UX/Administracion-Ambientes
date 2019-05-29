select * from ENTITY where idEnt in ('10094','10095');
select * from ATTRIB;
select * from BIZAGIINFO;

/*
10001
10061
*/
update ENTITY set entContentType=2 where idEnt=10001
update ENTITY set entContentType=2 where idEnt=10061

select * from ENTITY where idEnt in ('10001','10061');
select * from ENTITY where entDisplayName like ('Motivo%');