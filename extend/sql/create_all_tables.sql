create schema if not exists osm;

----- administrative boundries
create table osm.boundary(
	id serial not null primary key,
	osm_id integer,
	name text,
	uppername text,
	geom geometry(multipolygon, 0)
);
create index gix_boundary on osm.boundary using gist(geom);


create table osm.administrative_2(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_2 on osm.administrative_2 using gist(geom);


create table osm.administrative_3(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_3 on osm.administrative_3 using gist(geom);


create table osm.administrative_4(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_4 on osm.administrative_4 using gist(geom);

create table osm.administrative_5(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_5 on osm.administrative_5 using gist(geom);

create table osm.administrative_6(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_6 on osm.administrative_6 using gist(geom);

create table osm.administrative_7(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_7 on osm.administrative_7 using gist(geom);

create table osm.administrative_8(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_8 on osm.administrative_8 using gist(geom);

create table osm.administrative_9(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_9 on osm.administrative_9 using gist(geom);

create table osm.administrative_10(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_10 on osm.administrative_10 using gist(geom);

create table osm.administrative_11(
  id serial not null primary key,
  osm_id integer,
  name text,
  uppername text,
  geom geometry(multipolygon, 0)
);
create index gix_administrative_11 on osm.administrative_11 using gist(geom);
-------------------------------------------

create table osm.amenity(
	id serial not null primary key,
	osm_id integer,
	geom geometry(multipolygon, 0)
);
create index gix_amenity on osm.amenity using gist(geom);

create table osm.buildings(
  id serial not null primary key,
  osm_id integer,
  name text,
  housename text,
  housenumber text,
  geom geometry(multipolygon, 0)
);
create index gix_buildings on osm.buildings using gist(geom);

create table osm.forestpark(
  id serial not null primary key,
  osm_id integer,
  name text,
  geom geometry(multipolygon, 0)
);
create index gix_forestpark on osm.forestpark using gist(geom);


create table osm.lakes(
  id serial not null primary key,
  osm_id integer,
  name text,
  way_area real,
  geom geometry(multipolygon, 0)
);
create index gix_lakes on osm.lakes using gist(geom);

create table osm.minor_roads(
  id serial not null primary key,
  osm_id integer,
  name text,
  geom geometry(multilinestring, 0)
);
create index gix_minor_roads on osm.minor_roads using gist(geom);

create table osm.motorway(
  id serial not null primary key,
  osm_id integer,
  name text,
  geom geometry(multilinestring, 0)
);
create index gix_motorway on osm.motorway using gist(geom);

create table osm.pedestrian(
  id serial not null primary key,
  osm_id integer,
  name text,
  geom geometry(multilinestring, 0)
);
create index gix_pedestrian on osm.pedestrian using gist(geom);

create table osm.rails(
  id serial not null primary key,
  osm_id integer,
  name text,
  geom geometry(multilinestring, 0)
);
create index gix_rails on osm.rails using gist(geom);

create table osm.roads(
  id serial not null primary key,
  osm_id integer,
  name text,
  geom geometry(multilinestring, 0)
);
create index gix_roads on osm.roads using gist(geom);

create table osm.trunk_primary(
  id serial not null primary key,
  osm_id integer,
  name text,
  geom geometry(multilinestring, 0)
);
create index gix_trunk_primary on osm.trunk_primary using gist(geom);

create table osm.water(
  id serial not null primary key,
  osm_id integer,
  name text,
  geom geometry(multipolygon, 0)
);
create index gix_water on osm.water using gist(geom);

create table osm.waterway(
  id serial not null primary key,
  osm_id integer,
  name text,
  waterway text,
  geom geometry(multilinestring, 0)
);
create index gix_waterway on osm.waterway using gist(geom);
