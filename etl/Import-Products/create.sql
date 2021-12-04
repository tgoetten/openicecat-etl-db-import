CREATE TABLE product
(
  ID  SERIAL PRIMARY KEY,
  langid integer not null,
  path text,
  product_id integer not null,
  updated text,
  date_added text,
  quality text,
  supplier_id integer not null,
  prod_id text,
  catid integer not null,
  on_market integer,
  stock integer,
  model_name text,
  product_view integer not null,
  highpic text,
  highpicsize integer not null,
  highpicwidth integer not null,
  highpicheight integer not null,
  distributor_info_updated integer,
  limited text,
--  constraint product_langid FOREIGN KEY (langid) references language (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
--  constraint product_supplier FOREIGN KEY (supplier_id) references supplier (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO action,
--  constraint product_catid FOREIGN KEY (catid) references category (catid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO action,
  constraint product_prod_id_ukey unique (langid,product_id,supplier_id)
  ) WITH (OIDS = FALSE);

CREATE TABLE product_country_markets
(
  ID SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  value TEXT,
--  constraint product_country_markets FOREIGN KEY (product_id) references product (product_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO action,
  CONSTRAINT product_country_markets_ukey unique (product_id, value)
) WITH (OIDS = FALSE);

CREATE TABLE product_m_prod_id
(
  ID SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  supplier_id INT,
  supplier_name text,
  m_prod_id text not NULL,
  -- constraint product_m_prod_id_product_id FOREIGN KEY (product_id) references product (product_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO action,
  -- constraint product_m_prod_id_supplier_id FOREIGN KEY (supplier_id) references supplier (id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO action,
  CONSTRAINT product_m_prod_id_ukey unique (product_id, m_prod_id, supplier_id)
  ) WITH (OIDS = FALSE);

CREATE TABLE product_ean_upc
(
  ID SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  value text,
  isapproved INT
--  constraint product_ean_upc_product_id FOREIGN KEY (product_id) references product (product_id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO action
--  CONSTRAINT product_ean_upc_ukey unique (product_id, value)
  ) WITH (OIDS = FALSE);
