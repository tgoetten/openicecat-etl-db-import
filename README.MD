In product XML feeds, you will find a lot of structures, which are included as references in the product data files, e.g. categories, features, measures (units) etc.
The reference files can be found for Open Icecat at https://data.Icecat.biz/export/freexml/refs/

List of files (in order)
(/) LanguageList.xml.gz
(/) SuppliersList.xml.gz
(/) CategoriesList.xml.gz
(/) CategoryFeaturesList.xml.gz
(/) FeaturesList.xml.gz
RelationsList.xml -- angefangen, brauchen wir aber nicht
SupplierProductFamiliesListRequest.xml.gz

CampaignsList.xml (with the documentation)
MeasuresList.xml.gz
FeatureValuesVocabularyList.xml.gz

## Import-Products
Downloads file.index.xml, creates the 'product' table, and imports them
Configuration is made trough config/config.env
Product table is dropped upon start
the script creates a backup of all serialised cube files just in case

sh ImportProducts.sh

ToDo
- make it work for daily downloads
+ download xml file als wiederverwendbarer, generischer  job -- ginge nicht für RelationsList; ist aber aktuell eh nicht fertig und wichtig
+ change charactertext varying to text! in all initialise database steps

Info
- Language ist fürn arsch! anders als gedacht enthält language_name zwar die Übersetzung pro sprache, ist aber sehr schlecht! kann ignoriert werden
- Category_Keywords ist ebenfalls unbrauchbar. 400k Einträge one keywords!!

## Prerequisits
- docker
- hitachi data integration
- download / run everything the same day to avoid missing categories etc.

## Fresh Install

### Basic Setup
1. Have a look at the function perform_import() found in sources.sh and uncomment either line 240 or 242
2. DROP and re-CREATE the database
  docker exec -i openicecat-etl-db psql --host=localhost --username=unicorn_user --dbname=rainbow_database -c "DROP DATABASE unicorn_database;"
  docker exec -i openicecat-etl-db psql --host=localhost --username=unicorn_user --dbname=rainbow_database -c "CREATE DATABASE unicorn_database WITH ENCODING='UTF8' OWNER=unicorn_user;"

3. Start the Import
# ./ImportAll.sh --help
./ImportAll.sh --delete-cube --delete-xml  

(!) Make sure, that we 1) have a backup of all ProductDetails XML files and 2) that only the XML files the general setup are deleted!!!

find . -type f -name "*.xml" -exec echo rm {} \;
find . -type f -not -path "./Import-ProductDetails/downloaded-data/*" -name "*.xml" -exec echo rm '{}' \;  

>>> - Kitchen - Processing ended after 1 hours, 18 minutes and 30 seconds (4710 seconds total).

### Products
4. Import-Products

Have a look at Import-Products.sh and decide if you would like to use the cube files or not
 cd Import-Products

>>>  Processing ended after 2 hours, 50 minutes and 51 seconds (10251 seconds total).

### Product Details
5. Import-ProductDetails

First, make sure there are no empty / 0 byte files
 find /home/thomas/Workspace/openicecat-etl-db-import/etl/Import-ProductDetails/downloaded-data/1/ -type f -empty -delete
 find /home/thomas/Workspace/openicecat-etl-db-import/etl/Import-ProductDetails/downloaded-data/4/ -type f -empty -delete

Second, open the Job in spoon OR run it in terminal

 cd openicecat-etl-db-import/etl/Import-ProductDetails
 export PENTAHO_DI_JAVA_OPTIONS="-Xmx16g -XX:MaxPermSize=512m" && sh /opt/data-integration/kitchen.sh -file="Import all Product XML files in download folder.kjb" "Import all Product XML files in download folders.kjb" -level=Basic -logfile="Import all Product XML files in download folders.txt" -param:create=true -param:drop=true -param:extract=false -param:skip_download=true

>>> Processing ended after ~ 2 hours, 2 minutes
>>> 2021/09/22 07:46:15 - Processing ended after 10 hours, 7 minutes and 2 seconds
>>> 6210 Files
545
2021/09/21 21:39:34.093;985389880;1;540624.xml;file:///home/thomas/Workspace/openicecat-etl-db-import/etl/Import-ProductDetails/downloaded-data/1/540624.xml
2021/09/21 21:39:40.558;630000000;4;540624.xml;file:///home/thomas/Workspace/openicecat-etl-db-import/etl/Import-ProductDetails/downloaded-data/4/540624.xml


>>> 2021/09/27 07:45:36 - Processing ended after 16 hours, 45 minutes and 11 seconds (60311 seconds total).
6210 device XMLs

3h 48m 19s
2021/09/10 21:05:33 - Spoon - Job has ended.


find -type f -name "*.xml" | wc -l
9.434 files

select langid, count(id) from product__productdetails pp group by langid ;

5. Import-ProductDetails for devices
Please have a look at LoadProductDetails.sh first to make sure create, drop & skip_download are set according to your needs

./LoadProductDetails.sh

>>> Processing ended after 1 hours, 45 minutes and 17 seconds (6317 seconds total)

### Manually download missing XML files
cd openicecat-etl-db-import/etl/Import-ProductDetails/downloaded-data
cd 1
wget --user ounlimited --password Monday28$ http://data.icecat.biz/export/freexml.int/EN/15721878.xml
cd ..
cd 4
wget --user ounlimited --password Monday28$ http://data.icecat.biz/export/freexml.int/DE/15721878.xml
### Manually Import missing XML files

cd openicecat-etl-db-import/etl/Import-ProductDetails
export PENTAHO_DI_JAVA_OPTIONS="-Xmx16g -XX:MaxPermSize=512m" && sh /opt/data-integration/kitchen.sh -file=Import-ProductDetails.kjb Import-ProductDetails.kjb -level=Basic -logfile=Import-ProductDetails.txt -param:create=false -param:drop=false -param:filename=15721878.xml -param:langid=1 -param:skip_download=true -param:url=http://data.icecat.biz/export/freexml.int/EN/15721878.xml

## Problems to solve
- Import-Products.sh more parameter, same as ImportAll.sh
- Import-Products.sh more RAM

## Maintenance
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO public;

SELECT schemaname,relname,n_live_tup
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC;

Backup
docker exec -t openicecat-etl-db pg_dump -c --username=unicorn_user rainbow_database | gzip -9 > backup-pg_dump_-_rainbow_database_-`date +%d-%m-%Y"_"%H_%M_%S`.sql.gz
docker exec -t openicecat-etl-db pg_dump -c --username=unicorn_user unicorn_database | gzip -9 > backup-pg_dump_-_unicorn_database_-`date +%d-%m-%Y"_"%H_%M_%S`.sql.gz

Restore
docker exec -i openicecat-etl-db psql --host=localhost --username=unicorn_user --dbname=rainbow_database -c "DROP DATABASE unicorn_database;"
docker exec -i openicecat-etl-db psql --host=localhost --username=unicorn_user --dbname=rainbow_database -c "CREATE DATABASE unicorn_database WITH ENCODING='UTF8' OWNER=unicorn_user;"

docker exec -i openicecat-etl-db psql --host=localhost --username=unicorn_user --dbname=unicorn_database -c "DROP DATABASE rainbow_database;"
docker exec -i openicecat-etl-db psql --host=localhost --username=unicorn_user --dbname=unicorn_database -c "CREATE DATABASE rainbow_database WITH ENCODING='UTF8' OWNER=unicorn_user;"
