CREATE TABLE product__feature (
  ID SERIAL PRIMARY KEY, 
  class integer,
  defaultdisplayunit integer,
  measure_sign character varying,
  type character varying
) WITH (OIDS = FALSE);

CREATE TABLE product__feature_description (
  ID SERIAL PRIMARY KEY, 
  description character varying, 
  langid integer, 
  product__feature_id integer,
  constraint product__feature_description_product__feature FOREIGN KEY (product__feature_id) references product__feature (ID) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint product__feature_description_langid FOREIGN KEY (langid) references language (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint product__feature_description_ukey UNIQUE (ID, langid)
) WITH (OIDS = FALSE);

CREATE TABLE product__feature_name (
  ID SERIAL PRIMARY KEY, 
  name character varying, 
  langid integer, 
  product__feature_id integer,
  constraint product__feature_name_product__feature FOREIGN KEY (product__feature_id) references product__feature (ID) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint product__feature_name_langid FOREIGN KEY (langid) references language (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint product__feature_name_ukey UNIQUE (ID, langid)
) WITH (OIDS = FALSE);
