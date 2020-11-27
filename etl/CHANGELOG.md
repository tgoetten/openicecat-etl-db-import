2020-11-26
        modified:   etl/Import-ProductDetails/Import-ProductDetails.kjb
Added command line parameter to skip download of XML files if they are already available

        modified:   etl/Import-ProductDetails/ParseXML.ktr
Added parsing of ProductPicture

        modified:   etl/Import-ProductDetails/create.sql
Table for ProductPictures was added
        modified:   etl/Import-Products/ParseXML.ktr


2020-10-17

Step: "Insert / update ProductRelated"
Update Fields: Table Field "product_id" Update to 'N' (was 'Y');
I hope to solve the duplicate entries in the table "product__productrelated"

Manually deleted the constraints

ALTER TABLE product__productrelated DROP CONSTRAINT product__productrelated_product;
ALTER TABLE product__productdescription DROP CONSTRAINT product__productdescription_product;
ALTER TABLE product__summarydescription DROP CONSTRAINT product__summarydescription_product;
ALTER TABLE product__productfeature DROP CONSTRAINT product__productfeature_product;
