BEGIN TRANSACTION;

-----------------------------------------
insert into osm.amenity(osm_id, geom) 
	SELECT planet_osm_polygon.osm_id,
    st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
   FROM planet_osm_polygon
  WHERE planet_osm_polygon.amenity IS NOT NULL AND (planet_osm_polygon.amenity = ANY (ARRAY['college'::text, 'community_centre'::text, 'courthouse'::text, 'doctors'::text, 'embassy'::text, 'grave_yard'::text, 'hospital'::text, 'library'::text, 'marketplace'::text, 'prison'::text, 'public_building'::text, 'school'::text, 'simming_pool'::text, 'theatre'::text, 'townhall'::text, 'university'::text]));

insert into osm.buildings(osm_id, name, housename, housenumber, geom) 
    SELECT planet_osm_polygon.osm_id, 
      planet_osm_polygon.name,  
      planet_osm_polygon."addr:housename",
       planet_osm_polygon."addr:housenumber",
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.building IS NOT NULL AND st_area(planet_osm_polygon.way) < 100000::double precision;

insert into osm.forestpark(osm_id, name, geom) 
  SELECT planet_osm_polygon.osm_id, 
    planet_osm_polygon.name, 
    st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
  FROM planet_osm_polygon
  WHERE (planet_osm_polygon.landuse = ANY (ARRAY['forest'::text, 'orchard'::text, 'park'::text, 'plant_nursery'::text, 'grass'::text, 'greenfield'::text, 'meadow'::text, 'recreation_ground'::text, 'village_green'::text, 'vineyard'::text])) OR (planet_osm_polygon.leisure = ANY (ARRAY['nature_reserve'::text, 'park'::text, 'dog_park'::text, 'garden'::text, 'golf_course'::text, 'horse_riding'::text, 'recreation_ground'::text, 'stadium'::text]));

insert into osm.lakes(osm_id, name, way_area, geom) 
  SELECT planet_osm_polygon.osm_id, 
    planet_osm_polygon.name,  
    planet_osm_polygon.way_area,
    st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
  FROM planet_osm_polygon
  WHERE planet_osm_polygon."natural" = 'water'::text AND (planet_osm_polygon.water IS NULL OR planet_osm_polygon.water IS NOT NULL AND planet_osm_polygon.water <> 'river'::text);

insert into osm.minor_roads(osm_id, name, geom) 
  SELECT planet_osm_line.osm_id, 
    planet_osm_line.name,  
    st_multi(planet_osm_line.way)::geometry(MultiLineString, 0) as way
  FROM planet_osm_line
  WHERE planet_osm_line.highway IS NOT NULL AND (planet_osm_line.highway <> ALL (ARRAY['motorway'::text, 'motorway_link'::text, 'trunk'::text, 'primary'::text, 'trunk_link'::text, 'primary_link'::text, 'secondary'::text, 'secondary_link'::text, 'road'::text, 'tertiary'::text, 'tertiary_link'::text, 'steps'::text, 'footway'::text, 'path'::text, 'pedestrian'::text, 'walkway'::text, 'service'::text, 'track'::text])) AND planet_osm_line.railway IS NULL OR planet_osm_line.railway = 'no'::text;

insert into osm.motorway(osm_id, name, geom) 
  SELECT planet_osm_line.osm_id, 
 	  planet_osm_line.name,  
    st_multi(planet_osm_line.way)::geometry(MultiLineString, 0) as way
  FROM planet_osm_line
  WHERE planet_osm_line.highway = 'motorway'::text;

insert into osm.pedestrian(osm_id, name, geom) 
  SELECT planet_osm_line.osm_id, 
   	planet_osm_line.name, 
    st_multi(planet_osm_line.way)::geometry(MultiLineString, 0) as way
  FROM planet_osm_line
  WHERE planet_osm_line.highway = ANY (ARRAY['steps'::text, 'footway'::text, 'path'::text, 'pedestrian'::text, 'walkway'::text, 'service'::text, 'track'::text]);

insert into osm.rails(osm_id, name, geom) 
  SELECT planet_osm_line.osm_id, 
    planet_osm_line.name,  
    st_multi(planet_osm_line.way)::geometry(MultiLineString, 0) as way
  FROM planet_osm_line
  WHERE planet_osm_line.railway IS NOT NULL AND (planet_osm_line.railway = ANY (ARRAY['light rail'::text, 'rail'::text, 'rail;construction'::text, 'tram'::text, 'yes'::text, 'traverser'::text])) OR planet_osm_line.railway ~~ '%rail%'::text;

insert into osm.roads(osm_id, name, geom) 
 SELECT planet_osm_line.osm_id, 
    planet_osm_line.name,  
    st_multi(planet_osm_line.way)::geometry(MultiLineString, 0) as way
   FROM planet_osm_line
  WHERE planet_osm_line.highway = ANY (ARRAY['trunk_link'::text, 'primary_link'::text, 'secondary'::text, 'secondary_link'::text, 'road'::text, 'tertiary'::text, 'tertiary_link'::text]);

insert into osm.trunk_primary(osm_id, name, geom) 
  SELECT planet_osm_line.osm_id, 
    planet_osm_line.name, 
    st_multi(planet_osm_line.way)::geometry(MultiLineString, 0) as way
  FROM planet_osm_line
  WHERE planet_osm_line.highway = ANY (ARRAY['motorway_link'::text, 'trunk'::text, 'primary'::text]);

insert into osm.water(osm_id, name, geom) 
  SELECT planet_osm_polygon.osm_id, 
    planet_osm_polygon.name,  
    st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
  FROM planet_osm_polygon
  WHERE planet_osm_polygon."natural" = 'water'::text OR planet_osm_polygon.water IS NOT NULL OR planet_osm_polygon.waterway ~~ '%riverbank%'::text;

insert into osm.waterway(osm_id, name, waterway, geom) 
  SELECT planet_osm_line.osm_id, 
    planet_osm_line.name,  
    planet_osm_line.waterway,
    st_multi(planet_osm_line.way)::geometry(MultiLineString, 0) as way
  FROM planet_osm_line
  WHERE planet_osm_line.waterway = ANY (ARRAY['drain'::text, 'canal'::text, 'waterfall'::text, 'river'::text, 'stream'::text, 'yes'::text]);
-----------------------------------------
insert into osm.administrative_2(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '2'::text AND planet_osm_polygon.boundary = 'administrative'::text;

insert into osm.administrative_3(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '3'::text AND planet_osm_polygon.boundary = 'administrative'::text;

insert into osm.administrative_4(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '4'::text AND planet_osm_polygon.boundary = 'administrative'::text;

insert into osm.administrative_5(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '5'::text AND planet_osm_polygon.boundary = 'administrative'::text;

insert into osm.administrative_6(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '6'::text AND planet_osm_polygon.boundary = 'administrative'::text;

insert into osm.administrative_7(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '7'::text AND planet_osm_polygon.boundary = 'administrative'::text;

insert into osm.administrative_8(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '8'::text AND planet_osm_polygon.boundary = 'administrative'::text;

insert into osm.administrative_9(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '9'::text AND planet_osm_polygon.boundary = 'administrative'::text;

insert into osm.administrative_10(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '10'::text AND planet_osm_polygon.boundary = 'administrative'::text;

insert into osm.administrative_11(osm_id, name, uppername, geom) 
    SELECT planet_osm_polygon.osm_id,
      planet_osm_polygon.name as name,
      upper(planet_osm_polygon.name) AS uppername,
      st_multi(planet_osm_polygon.way)::geometry(MultiPolygon, 0) as way
    FROM planet_osm_polygon
    WHERE planet_osm_polygon.admin_level = '11'::text AND planet_osm_polygon.boundary = 'administrative'::text;
-----------------------------------------

COMMIT;