-- Creo esquema:
create schema practinmabautista2;

-- Creo tabla coches:
create table practinmabautista2.coches(
	id serial primary key,
	id_modelo int not null,
	fecha_compra date not null,
	id_color int not null,
	matricula VARCHAR(30) not null,
	fecha_baja date
);

-- Creo tabla modelos de coches:
CREATE TABLE practinmabautista2.modelos(
	id_modelo serial PRIMARY KEY,
	modelo varchar(30) NOT NULL,
	id_marca int NOT NULL
);

-- Creo la tabla de marca de coches:
CREATE TABLE practinmabautista2.marcas(
	id_marca serial PRIMARY KEY,
	marca varchar(30) NOT NULL, 
	id_grupo int NOT NULL
);

-- Creo la tabla de grupo empresarial de coches:
CREATE TABLE practinmabautista2.gruposempresariales(
	id_grupo serial PRIMARY KEY,
	grupo varchar(30) NOT null
);	

-- Creo la tabla colores de coche:
CREATE TABLE practinmabautista2.colores(
	id_color serial PRIMARY KEY,
	color varchar(30) NOT null
);

-- Creo tabla seguros:
create table practinmabautista2.seguros(
	id_seguro serial primary key,
	num_poliza VARCHAR(30) not null,
	id_aseguradora int not null,
	fecha_poliza date,
	fecha_vencimiento date not null,
	id_coche int not null
);

-- Creo tabla aseguradora:
CREATE TABLE practinmabautista2.aseguradoras(
	id_aseguradora serial PRIMARY KEY,
	aseguradora varchar(30) NOT null
);

-- Creo tabla revisiones:
create table practinmabautista2.revisiones(
	id_revision serial primary key,
	fecha_revision date not null,
	kilometros int not null,
	conceptos VARCHAR(100),
	importe decimal(10,2) not null,
	id_moneda int not null,
	id_coche int not null
);

-- Creo tabla moneda:
CREATE TABLE practinmabautista2.monedas(
	id_moneda serial PRIMARY KEY,
	moneda varchar(30) NOT NULL
);

-- Creo tabla viajes:
create table practinmabautista2.viajes(
	id_viaje serial primary key,
	fecha_viaje date not null,
	km_realizados int,
	km_final_viaje int not null,
	id_usuario int not null,
	id_coche int not null
);

-- Creo tabla usuarios:
CREATE TABLE practinmabautista2.usuarios(
	id_usuario serial PRIMARY KEY,
	usuario varchar(30)
);

-- Creo las relaciones entre tablas:
alter table practinmabautista2.seguros add constraint pk_seguros foreign key (id_coche) references practinmabautista2.coches(id);
alter table practinmabautista2.revisiones add constraint pk_revisiones foreign key (id_coche) references practinmabautista2.coches(id);
alter table practinmabautista2.viajes add constraint pk_viajes foreign key (id_coche) references practinmabautista2.coches(id);
ALTER TABLE practinmabautista2.coches ADD CONSTRAINT pk_modelos foreign KEY (id_modelo) REFERENCES practinmabautista2.modelos(id_modelo);
ALTER TABLE practinmabautista2.coches ADD CONSTRAINT pk_colores foreign KEY (id_color) REFERENCES practinmabautista2.colores(id_color);
ALTER TABLE practinmabautista2.modelos ADD CONSTRAINT pk_marcas foreign KEY (id_marca) REFERENCES practinmabautista2.marcas(id_marca);
ALTER TABLE practinmabautista2.marcas ADD CONSTRAINT pk_gruposempresariales foreign KEY (id_grupo) REFERENCES practinmabautista2.gruposempresariales(id_grupo);
ALTER TABLE practinmabautista2.viajes ADD CONSTRAINT pk_usuarios foreign key (id_usuario) REFERENCES practinmabautista2.usuarios(id_usuario);
ALTER TABLE practinmabautista2.revisiones ADD CONSTRAINT pk_monedas foreign KEY (id_moneda) REFERENCES practinmabautista2.monedas(id_moneda);
ALTER TABLE practinmabautista2.seguros ADD CONSTRAINT pk_aseguradoras foreign KEY (id_aseguradora) REFERENCES practinmabautista2.aseguradoras(id_aseguradora);

-- Introduzco datos en tabla grupos empresariales de coches:
insert into practinmabautista2.gruposempresariales(grupo)values
('Grupo PSA'),
('Grupo Ford'),
('Grupo Volkswagen');

-- Introduzco datos en tabla marcas de coches:
insert into practinmabautista2.marcas(marca,id_grupo)values
('Citroen', 1),
('Ford',2),
('Audi',3),
('Seat',3),
('Volkswagen',3);

-- Introduzco datos en tabla modelos de coches:
insert into practinmabautista2.modelos(modelo,id_marca)values
('Berlingo',1),
('Puma ST',2),
('A6',3),
('Ibiza',4),
('Yeta', 5);

-- Introduzco datos en la tabla colores:
insert into practinmabautista2.colores(color)values
('Negro'),
('Blanco'),
('Gris');

-- Introduzco datos en tabla coches, primero de los coches activos en la tabla coches:
insert into practinmabautista2.coches(id_modelo,fecha_compra,id_color,matricula)values
(1,'2020-05-19',1,'7070KMJ'),
(2,'2023-01-30',2,'3021MAM'),
(3,'2019-12-11',3,'5600EMN'),
(4,'2019-01-25',2,'4255FLK');

-- Inserto dato de un coche dado de baja:
insert into practinmabautista2.coches(id_modelo,fecha_compra,id_color,matricula,fecha_baja)values
(5,'2000-05-19',2,'CO1442AV','2005-12-20');

-- Inserto datos en tabla de aseguradoras:
insert into practinmabautista2.aseguradoras(aseguradora)values
('Mafre'),
('Axa');

-- Inserto datos en la tabla seguros:
insert into practinmabautista2.seguros(num_poliza,id_aseguradora,fecha_poliza,fecha_vencimiento,id_coche) values
('99099809878898',1,'2020-05-19','2024-05-19',1),
('93245468811100',1,'2019-12-11','2023-12-11',3),
('11110004448',2,'2023-01-30','2024-01-30',2),
('11398473923',2,'2019-01-25','2024-01-25',4);

-- Inserto datos en tabla monedas:
insert into practinmabautista2.monedas(moneda) values
('€'),
('$');

-- Inserto datos en tabla revisiones:
insert into practinmabautista2.revisiones(fecha_revision,kilometros,conceptos,importe,id_moneda,id_coche) values
('2022-01-24',47000,'Cambio de aceite y filtros',380,1,1),
('2022-02-20',1000,'Revision inicial' ,200,1,2),
('2023-05-23',53000,'Cambio de neumáticos',2500,1,3),
('2023-01-16',80000,'Cambio de aceite y filtros',400,1,4),
('2023-08-02',89000,'Reparacion motor',1500,2,4);

-- Inserto datos en tabla usuarios:
insert into practinmabautista2.usuarios(usuario) values
('Jose Luis'),
('Amanda'),
('Pepe'),
('Rigoberta');

-- Inserto datos en tabla viajes:
insert into practinmabautista2.viajes(fecha_viaje,km_realizados,km_final_viaje,id_usuario,id_coche)values
('2023-01-18',169,47801,1,1),
('2023-03-31',56,67801,2,3),
('2023-05-02',348,2500,3,2),
('2023-08-19',549,90456,4,4),
('2023-09-01',1000,91456,3,4),
('2023-09-10',500,50000,1,1);

-- Consulta solicitada en la práctica:

select 
CONCAT(m.modelo,'-', ma.marca, '-', g.grupo) AS "Modelo-Marca-Grupo",
c.fecha_compra as "Fecha_de_compra",
c.matricula as "Matricula",
co.color as "Color", 
v.km_final_viaje as "Kilometros_totales",
a.aseguradora as "Aseguradora",  
s.num_poliza as "Numero_de_poliza"

from practinmabautista2.coches c 

left join (
select
v1.id_coche,
max(v1.fecha_viaje) as Ultima_fecha_viaje,
v1.km_final_viaje 
from practinmabautista2.viajes v1
inner join (
select
id_coche,
max(fecha_viaje) as ultima_fecha
from practinmabautista2.viajes group by id_coche
) as v2max  on v1.id_coche = v2max.id_coche and v1.fecha_viaje = v2max.ultima_fecha
group by v1.id_coche, v1.km_final_viaje
) as v on c.id = v.id_coche 

left join practinmabautista2.seguros s on c.id = s.id_coche
LEFT JOIN practinmabautista2.modelos m ON c.id_modelo = m.id_modelo
LEFT JOIN practinmabautista2.marcas ma ON m.id_marca = ma.id_marca
LEFT JOIN practinmabautista2.gruposempresariales g ON ma.id_grupo = g.id_grupo
LEFT JOIN practinmabautista2.aseguradoras a ON a.id_aseguradora = s.id_aseguradora
LEFT JOIN practinmabautista2.colores co ON co.id_color = c.id_color
where c.fecha_baja is null;
