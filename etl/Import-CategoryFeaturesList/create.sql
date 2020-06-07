-- https://codebeautify.org/sqlformatter
CREATE TABLE category__categoryfeaturegroup (
  ID SERIAL PRIMARY KEY, 
  No integer, 
  category_id integer
) WITH (OIDS = FALSE);

CREATE TABLE category__categoryfeaturegroup__featuregroup (
--  ID SERIAL PRIMARY KEY,
  ID integer,
  category_id integer,
  category__categoryfeaturegroup_id integer
) WITH (OIDS = FALSE);

CREATE TABLE category__categoryfeaturegroup__featuregroup__name (
  ID SERIAL PRIMARY KEY, 
  value character varying, 
  langid integer, 
  category__categoryfeaturegroup__featuregroup_id integer
) WITH (OIDS = FALSE);

CREATE TABLE category__feature (
--  ID SERIAL PRIMARY KEY, 
  ID integer, 
  category__feature_categoryfeaturegroup_id integer,
  category__feature_categoryfeature_id integer,
  class integer,
  limitdirection integer,
  mandatory integer,
  no integer,
  searchable integer,		
  type character varying,
  use_dropdown_input character varying,	
  valuesorting integer,
  measure_sign character varying,
  category_id integer
) WITH (OIDS = FALSE);

CREATE TABLE category__feature__name (
--  ID SERIAL PRIMARY KEY, 
  ID integer, 
  value character varying, 
  langid integer, 
  category__feature_id integer
) WITH (OIDS = FALSE);
