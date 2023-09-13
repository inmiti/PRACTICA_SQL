
-- Creo esquema:
create schema practinmabautista;

-- Creo tabla Coches:
create table practinmabautista.coches(
	id serial primary key,
	marca_modelo_grupo VARCHAR(60) not null,
	fecha_compra date not null,
	color VARCHAR(30) not null,
	matricula VARCHAR(30) not null,
	fecha_baja date
);


-- Creo tabla seguros:
create table practinmabautista.seguros(
	id_seguro serial primary key,
	num_poliza VARCHAR(30) not null,
	aseguradora VARCHAR(30) not null,
	fecha_poliza date,
	fecha_vencimiento date not null,
	id_coche int not null
);

-- Creo tabla revisiones:
create table practinmabautista.revisiones(
	id_revision serial primary key,
	fecha_revision date not null,
	kilometros int not null,
	conceptos VARCHAR(100),
	importe€ decimal(10,2) not null,
	importe$ decimal(10,2) not null,
	id_coche int not null
);

-- Creo tabla viajes:
create table practinmabautista.viajes(
	id_viaje serial primary key,
	fecha_viaje date not null,
	km_realizados int,
	km_final_viaje int not null,
	usuario VARCHAR(30) not null,
	id_coche int not null
);

-- Creo las relaciones entre tablas:

alter table practinmabautista.seguros add constraint pk_seguros foreign key (id_coche) references practinmabautista.coches(id);
alter table practinmabautista.revisiones add constraint pk_revisiones foreign key (id_coche) references practinmabautista.coches(id);
alter table practinmabautista.viajes add constraint pk_viajes foreign key (id_coche) references practinmabautista.coches(id);

-- Introduzco datos en tabla coches, primero de los coches activos en la tabla coches:

insert into practinmabautista.coches(marca_modelo_grupo,fecha_compra,color,matricula)values
('Citroen Berlingo Grupo PSA', '2020-05-19','Negro','7070KMJ'),
('Ford Puma ST Grupo Ford','2023-01-30','Blanco','3021MAM'),
('Audi A6 Grupo Volkswagen','2019-12-11','Gris','5600EMN'),
('Seat Ibiza Grupo Volkswagen','2019-01-25','Blanco','4255FLK');

-- Inserto dato de un coche dado de baja:
insert into practinmabautista.coches(marca_modelo_grupo,fecha_compra,color,matricula,fecha_baja)values
('VolkswageN Yeta Grupo Volskwagen','2000-05-19','Blanco','CO1442AV','2005-12-20');

-- Inserto resto de datos del resto de tablas:
insert into practinmabautista.seguros(num_poliza, aseguradora, fecha_poliza, fecha_vencimiento, id_coche) values
('99099809878898','Mafre','2020-05-19','2024-05-19',1),
('93245468811100','Mafre','2019-12-11','2023-12-11',3),
('11110004448','Axa','2023-01-30','2024-01-30',2),
('11398473923','Axa','2019-01-25','2024-01-25',4);

insert into practinmabautista.revisiones(fecha_revision,kilometros,conceptos,importe€,importe$,id_coche) values
('2022-01-24',47000,'Cambio de aceite y filtros',380,370,1),
('2022-02-20',1000,'Revision inicial' , 200, 190,2),
('2023-05-23',53000,'Cambio de neumáticos', 2500,2400,3),
('2023-01-16',80000,'Cambio de aceite y filtros',400,390,4),
('2023-08-02',89000,'Reparacion motor',1500,1400,4);

insert into practinmabautista.viajes(fecha_viaje,km_realizados,km_final_viaje,usuario,id_coche)values
('2023-01-18',169,47801,'Jose Luis', 1),
('2023-03-31',56,67801,'Amanda', 3),
('2023-05-02',348,2500,'Pepe', 2),
('2023-08-19',549,90456,'Rigoberta', 4),
('2023-09-01',1000,91456,'Pepe', 4),
('2023-09-10',500,50000,'Jose Luis', 1);

-- Consulta solicitada en la práctica:

select 
c.marca_modelo_grupo as "Coche: Marca, modelo y grupo",
c.fecha_compra as "Fecha_de_compra",
c.matricula as "Matricula",
c.color as "Color",
v.km_final_viaje as "Kilometros_totales",
s.aseguradora as "Aseguradora",
s.num_poliza as "Numero_de_poliza"

from practinmabautista.coches c 

left join (
select
v1.id_coche,
max(v1.fecha_viaje) as Ultima_fecha_viaje,
v1.km_final_viaje 
from practinmabautista.viajes v1
inner join (
select
id_coche,
max(fecha_viaje) as ultima_fecha
from practinmabautista.viajes group by id_coche
) as v2max  on v1.id_coche = v2max.id_coche and v1.fecha_viaje = v2max.ultima_fecha
group by v1.id_coche, v1.km_final_viaje
) as v on c.id = v.id_coche 

left join practinmabautista.seguros s on c.id = s.id_coche
where c.fecha_baja is null;




