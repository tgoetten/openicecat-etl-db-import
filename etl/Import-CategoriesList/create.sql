-- https://codebeautify.org/sqlformatter
CREATE TABLE category (
  catid SERIAL PRIMARY KEY,
  parentcategory_id integer, -- pcatid
  lowpic character varying, 
  score integer, 
  searchable integer,
  thumbpic character varying, 
  uncatid character varying, -- ucatid
  visible integer
) WITH (OIDS = FALSE);

CREATE TABLE category_name (
  ID SERIAL PRIMARY KEY, 
  category_id integer, 
  value character varying, 
  langid integer, 
  constraint category_name_catid FOREIGN KEY (category_id) references category (catid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint category_name_langid FOREIGN KEY (langid) references language (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint category_name_ukey UNIQUE (category_id, langid)
) WITH (OIDS = FALSE);

CREATE TABLE category_description (
  ID SERIAL PRIMARY KEY, 
  category_id integer, 
  value character varying, 
  langid integer, 
  constraint category_description_catid FOREIGN KEY (category_id) references category (catid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint category_description_langid FOREIGN KEY (langid) references language (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint category_description_ukey UNIQUE (category_id, langid)
) WITH (OIDS = FALSE);

CREATE TABLE category_keywords (
  ID SERIAL PRIMARY KEY, 
  category_id integer, 
  value character varying, 
  langid integer, 
  constraint category_keywords_catid FOREIGN KEY (category_id) references category (catid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint category_keywords_langid FOREIGN KEY (langid) references language (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION, 
  constraint category_keywords_ukey UNIQUE (category_id, langid)
) WITH (OIDS = FALSE);
