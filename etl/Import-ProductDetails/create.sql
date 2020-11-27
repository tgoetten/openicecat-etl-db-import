CREATE TABLE product__productdetails
(
  ID SERIAL PRIMARY KEY,
  langid integer not null,
  product_id integer not null,
  -- columns derived from product detail files
  code integer,
  lowpic text,
  lowpicheight text,
  lowpicsize text,
  lowpicwidth integer,
  pic500x500 text,
  pic500x500height integer,
  pic500x500size integer,
  pic500x500width integer,
  releasedate text,
  thumbpic text,
  thumbpicsize integer,
  title text,
  constraint product_langid FOREIGN KEY (langid) references language (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT product__productdetails_prod_id_ukey unique (product_id, langid)
  ) WITH (OIDS = FALSE);

CREATE TABLE product__summarydescription (
  ID SERIAL PRIMARY KEY,
  shortsummarydescription_langid integer,
  shortsummarydescription_shortsummarydescription text,
  longsummarydescription_langid integer,
  longsummarydescription_longsummarydescription text,
  product_id integer,
--  constraint product__summarydescription_product FOREIGN KEY (product_id) references product (product_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  constraint product__summarydescription_shortsummarydescription_langid FOREIGN KEY (shortsummarydescription_langid) references language (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  constraint product__summarydescription_longsummarydescription_langid FOREIGN KEY (longsummarydescription_langid) references language (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS = FALSE);


CREATE TABLE product__productfeature (
  ID SERIAL PRIMARY KEY,
  productfeature_id integer,
  local_id integer,
  value text,
  localized text,
  no integer,
  presentation_value text,
  translated integer,
  mandatory integer,
  searchable integer,
  langid integer,
  localvalue_value text,
  localvalue__measure_id integer,
  localvalue__measure__sign_id integer,
  localvalue__measure__sign_langid integer,
  localvalue__measure__sign_sign text,
  feature_id integer,
  feature__measure_id integer,
  feature__measure_sign text,
  feature__measure__sign_id integer,
  feature__measure__sign_langid integer,
  feature__measure__sign_sign text,
  feature__name_id integer,
  feature__name_langid integer,
  feature__name_value text,
  product_id integer,
  categoryfeaturegroup_id integer,
--  constraint product__productfeature_product FOREIGN KEY (product_id) references product (product_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS = FALSE);

CREATE TABLE product__productrelated (
  ID SERIAL PRIMARY KEY,
  __product_id integer, -- taken from individual xml file to referr to the product that those relations apply to!
  productrelated_id integer,
  product_id integer,
  category_id integer,
  preferred integer,
  product_prod_id text,
  product_thumbpic text,
  product_name text,
  product__supplier_id integer,
  product__supplier_name text,
--  constraint product__productrelated_product FOREIGN KEY (__product_id) references product (product_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  constraint product__productrelated_supplier FOREIGN KEY (product__supplier_id) references supplier (ID) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS = FALSE);

CREATE TABLE product__productdescription (
  product_id integer,
  id integer,
  longdesc text,
  longdesc_escaped text,
  manualpdfsize integer,
  manualpdfurl text,
  pdfsize integer,
  pdfurl text,
  shortdesc text,
  shortdesc_escaped text,
  url text,
  warrantyinfo text,
  langid integer,
--  constraint product__productdescription_product FOREIGN KEY (product_id) references product (product_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  constraint product__productdescription_langid FOREIGN KEY (langid) references language (ID) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
) WITH (OIDS = FALSE);

CREATE TABLE product__productpicture (
  product_id integer,
  ID SERIAL PRIMARY KEY,
  productpicture_ismain text,
  productpicture_lowpic text,
  productpicture_lowpicheight integer,
  productpicture_lowpicwidth integer,
  productpicture_lowsize integer,
  productpicture_no integer,
  productpicture_original text,
  productpicture_originalsize integer,
  productpicture_pic text,
  productpicture_pic500x500 text,
  productpicture_pic500x500height integer,
  productpicture_pic500x500size integer,
  productpicture_pic500x500width integer,
  productpicture_picheight integer,
  productpicture_picwidth integer,
  productpicture_productpicture_id integer,
  productpicture_size integer,
  productpicture_source text,
  productpicture_thumbpic text,
  productpicture_thumbsize integer,
  productpicture_type text,
  productpicture_updateddate text
) WITH (OIDS = FALSE);
