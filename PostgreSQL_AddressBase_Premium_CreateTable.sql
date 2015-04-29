
CREATE EXTENSION postgis;

CREATE EXTENSION postgis_topology;

drop table if exists abp_blpu;
drop table if exists abp_delivery_point;
drop table if exists abp_lpi;
drop table if exists abp_crossref;
drop table if exists abp_classification;
drop table if exists abp_street;
drop table if exists abp_street_descriptor;
drop table if exists abp_organisation;
drop table if exists abp_successor;



--BLPU
CREATE TABLE abp_blpu (
RECORD_IDENTIFIER SMALLINT,
CHANGE_TYPE CHARACTER VARYING(1),
PRO_ORDER BIGINT,
UPRN BIGINT,
LOGICAL_STATUS SMALLINT,
BLPU_STATE SMALLINT,
BLPU_STATE_DATE DATE,
PARENT_UPRN BIGINT,
X_COORDINATE DOUBLE PRECISION,
Y_COORDINATE DOUBLE PRECISION,
RPC SMALLINT,
LOCAL_CUSTODIAN_CODE SMALLINT,
START_DATE DATE,
END_DATE DATE,
LAST_UPDATE_DATE DATE,
ENTRY_DATE DATE,
POSTAL_ADDRESS CHARACTER VARYING(1),
POSTCODE_LOCATOR CHARACTER VARYING(8),
MULTI_OCC_COUNT SMALLINT
);
--Classification
CREATE TABLE abp_classification (
RECORD_IDENTIFIER SMALLINT,
CHANGE_TYPE CHARACTER VARYING(1),
PRO_ORDER BIGINT,
UPRN BIGINT,
CLASS_KEY CHARACTER VARYING(14),
CLASSIFICATION_CODE CHARACTER VARYING(6),
CLASS_SCHEME CHARACTER VARYING(60),
SCHEME_VERSION DOUBLE PRECISION,
START_DATE DATE,
END_DATE DATE,
LAST_UPDATE_DATE DATE,
ENTRY_DATE DATE
);
--Application Cross reference table
CREATE TABLE abp_crossref (
RECORD_IDENTIFIER SMALLINT,
CHANGE_TYPE CHARACTER VARYING(1),
PRO_ORDER BIGINT,
UPRN BIGINT,
XREF_KEY CHARACTER VARYING(14),
CROSS_REFERENCE CHARACTER VARYING(50),
VERSION SMALLINT,
SOURCE CHARACTER VARYING(6),
START_DATE DATE,
END_DATE DATE,
LAST_UPDATE_DATE DATE,
ENTRY_DATE DATE
);

--Delivery Point Address
CREATE TABLE abp_delivery_point (
RECORD_IDENTIFIER SMALLINT,
CHANGE_TYPE CHARACTER VARYING(1),
PRO_ORDER BIGINT,
UPRN BIGINT,
PARENT_ADDRESSABLE_UPRN BIGINT,
RM_UDPRN BIGINT,
ORGANISATION_NAME CHARACTER VARYING(60),
DEPARTMENT_NAME CHARACTER VARYING(60),
SUB_BUILDING_NAME CHARACTER VARYING(30),
BUILDING_NAME CHARACTER VARYING(80),
BUILDING_NUMBER SMALLINT,
DEPENDENT_THOROUGHFARE_NAME CHARACTER VARYING(80),
THOROUGHFARE_NAME CHARACTER VARYING(80),
DOUBLE_DEPENDENT_LOCALITY CHARACTER VARYING(35),
DEPENDENT_LOCALITY CHARACTER VARYING(35),
POST_TOWN CHARACTER VARYING(30),
POSTCODE CHARACTER VARYING(8),
POSTCODE_TYPE CHARACTER VARYING(1),
WELSH_DEPENDENT_THOROUGHFARE_NAME CHARACTER VARYING(80),
WELSH_THOROUGHFARE_NAME CHARACTER VARYING(80),
WELSH_DOUBLE_DEPENDENT_LOCALITY CHARACTER VARYING(35),
WELSH_DEPENDENT_LOCALITY CHARACTER VARYING(35),
WELSH_POST_TOWN CHARACTER VARYING(30),
RM_PO_BOX_NUMBER CHARACTER VARYING(6),
RM_PROCESS_DATE DATE,
START_DATE DATE,
END_DATE DATE,
LAST_UPDATE_DATE DATE,
ENTRY_DATE DATE
);

--LPI
CREATE TABLE abp_lpi (
RECORD_IDENTIFIER SMALLINT,
CHANGE_TYPE CHARACTER VARYING(1),
PRO_ORDER BIGINT,
UPRN BIGINT,
LPI_KEY CHARACTER VARYING(14),
LANGUAGE CHARACTER VARYING(3),
LOGICAL_STATUS SMALLINT,
START_DATE DATE,
END_DATE DATE,
LAST_UPDATE_DATE DATE,
ENTRY_DATE DATE,
SAO_START_NUMBER SMALLINT,
SAO_START_SUFFIX CHARACTER VARYING(2),
SAO_END_NUMBER SMALLINT,
SAO_END_SUFFIX CHARACTER VARYING(2),
SAO_TEXT CHARACTER VARYING(90),
PAO_START_NUMBER SMALLINT,
PAO_START_SUFFIX CHARACTER VARYING(2),
PAO_END_NUMBER SMALLINT,
PAO_END_SUFFIX CHARACTER VARYING(2),
PAO_TEXT CHARACTER VARYING(90),
USRN INTEGER,
USRN_MATCH_INDICATOR CHARACTER VARYING(1),
AREA_NAME CHARACTER VARYING(35),
LEVEL CHARACTER VARYING(30),
OFFICIAL_FLAG CHARACTER VARYING(1)
);

--Organisation
CREATE TABLE abp_organisation (
RECORD_IDENTIFIER SMALLINT,
CHANGE_TYPE CHARACTER VARYING(1),
PRO_ORDER BIGINT,
UPRN BIGINT,
ORG_KEY CHARACTER VARYING(14),
ORGANISATION CHARACTER VARYING(100),
LEGAL_NAME CHARACTER VARYING(60),
START_DATE DATE,
END_DATE DATE,
LAST_UPDATE_DATE DATE,
ENTRY_DATE DATE
);

--Streets
CREATE TABLE abp_street (
RECORD_IDENTIFIER SMALLINT,
CHANGE_TYPE CHARACTER VARYING(1),
PRO_ORDER BIGINT,
USRN INTEGER,
RECORD_TYPE SMALLINT,
SWA_ORG_REF_NAMING SMALLINT,
STATE SMALLINT,
STATE_DATE DATE,
STREET_SURFACE SMALLINT,
STREET_CLASSIFICATION SMALLINT,
VERSION SMALLINT,
STREET_START_DATE DATE,
STREET_END_DATE DATE,
LAST_UPDATE_DATE DATE,
RECORD_ENTRY_DATE DATE,
STREET_START_X DOUBLE PRECISION,
STREET_START_Y DOUBLE PRECISION,
STREET_END_X DOUBLE PRECISION,
STREET_END_Y DOUBLE PRECISION,
STREET_TOLERANCE SMALLINT
);

--Street Descriptor
CREATE TABLE abp_street_descriptor (
RECORD_IDENTIFIER SMALLINT,
CHANGE_TYPE CHARACTER VARYING(1),
PRO_ORDER BIGINT,
USRN INTEGER,
STREET_DESCRIPTION CHARACTER VARYING(110),
LOCALITY_NAME CHARACTER VARYING(35),
TOWN_NAME CHARACTER VARYING(30),
ADMINISTRATIVE_AREA CHARACTER VARYING(30),
LANGUAGE CHARACTER VARYING(3)
);

--Successor Records
CREATE TABLE abp_successor (
RECORD_IDENTIFIER SMALLINT,
CHANGE_TYPE CHARACTER VARYING(1),
PRO_ORDER BIGINT,
UPRN BIGINT,
SUCC_KEY CHARACTER VARYING(14),
START_DATE DATE,
END_DATE DATE,
LAST_UPDATE_DATE DATE,
ENTRY_DATE DATE,
SUCCESSOR BIGINT
);



--Copy all the data into the tables

COPY abp_blpu FROM 'F:\Shapefiles\ab_premium\processed_csvs\ID21_BLPU_Records.csv' DELIMITER ',' CSV HEADER;
COPY abp_delivery_point FROM 'F:\Shapefiles\ab_premium\processed_csvs\ID28_DPA_Records.csv' DELIMITER ',' CSV HEADER;
COPY abp_lpi FROM 'F:\Shapefiles\ab_premium\processed_csvs\ID24_LPI_Records.csv' DELIMITER ',' CSV HEADER;
COPY abp_crossref FROM 'F:\Shapefiles\ab_premium\processed_csvs\ID23_XREF_Records.csv' DELIMITER ',' CSV HEADER;
COPY abp_classification FROM 'F:\Shapefiles\ab_premium\processed_csvs\ID32_Class_Records.csv' DELIMITER ',' CSV HEADER;
COPY abp_street FROM 'F:\Shapefiles\ab_premium\processed_csvs\ID11_Street_Records.csv' DELIMITER ',' CSV HEADER;
COPY abp_street_descriptor FROM 'F:\Shapefiles\ab_premium\processed_csvs\ID15_StreetDesc_Records.csv' DELIMITER ',' CSV HEADER ;
COPY abp_organisation FROM 'F:\Shapefiles\ab_premium\processed_csvs\ID31_Org_Records.csv' DELIMITER ',' CSV HEADER;
COPY abp_successor FROM 'F:\Shapefiles\ab_premium\processed_csvs\ID30_Successor_Records.csv' DELIMITER ',' CSV HEADER;



--Indexes and primary keys
--  BLPU

CREATE INDEX idx_blpu_uprn
  ON abp_blpu
  USING btree
  (uprn);

CREATE INDEX idx_blpu_custodian
  ON abp_blpu
  USING btree
  (local_custodian_code);

 CREATE INDEX idx_blpu_postcode
  ON  abp_blpu
  USING btree
  (postcode_locator); 

ALTER TABLE  abp_blpu ADD PRIMARY KEY (uprn);

ALTER TABLE abp_blpu ADD COLUMN arc_id serial ;

CREATE INDEX idx_arc_id_blpu
  ON abp_blpu
  USING btree
  (arc_id);

SELECT AddGeometryColumn ('public', 'abp_blpu', 'geom', 27700, 'POINT', 2);

UPDATE abp_blpu SET geom = ST_GeomFromText('POINT(' || x_coordinate || ' ' || y_coordinate || ')', 27700 );

CREATE INDEX idx_geom_blpu ON abp_blpu USING gist(geom);

-- delivery point

CREATE INDEX idx_dpa_postcode
  ON abp_delivery_point
  USING btree
  (postcode);

CREATE INDEX idx_dpa_thoroughfare
  ON abp_delivery_point
  USING btree
  (thoroughfare_name);  

CREATE INDEX idx_dpa_uprn
  ON abp_delivery_point
  USING btree
  (uprn);    
  
CREATE INDEX idx_dpa_post_town
  ON abp_delivery_point
  USING btree
  (post_town);
  

CREATE INDEX idx_dpa_organisation
  ON abp_delivery_point
  USING btree
  (organisation_name);  

ALTER TABLE abp_delivery_point ADD PRIMARY KEY (uprn);  

-- LPI

CREATE INDEX idx_lpi_uprn
  ON abp_lpi
  USING btree
  (uprn);

CREATE INDEX idx_lpi_pao_text
  ON abp_lpi
  USING btree
  (pao_text);    
  
CREATE INDEX idx_lpi_sao_text
  ON abp_lpi
  USING btree
  (sao_text);  
  
CREATE INDEX idx_lpi_area_name
  ON abp_lpi
  USING btree
  (area_name);  
  
ALTER TABLE abp_lpi ADD PRIMARY KEY (lpi_key);


-- cross_reference

CREATE INDEX idx_xref_uprn
  ON abp_crossref
  USING btree
  (uprn); 

CREATE INDEX idx_xref_source
  ON abp_crossref
  USING btree
  (source); 
  
CREATE INDEX idx_xref_cross_reference
  ON abp_crossref
  USING btree
  (cross_reference); 

ALTER TABLE abp_crossref ADD PRIMARY KEY (xref_key); 



-- classification

CREATE INDEX idx_class_classification
  ON abp_classification
  USING btree
  (classification_code);
  

CREATE INDEX idx_class_uprn
  ON abp_classification
  USING btree
  (uprn);
  
ALTER TABLE abp_classification ADD PRIMARY KEY (class_key);


 -- street

CREATE INDEX idx_usrn__street
  ON abp_street
  USING btree
  (usrn); 

ALTER TABLE abp_street ADD PRIMARY KEY (usrn); 

-- street descriptor

CREATE INDEX idx_street_descriptor_usrn
  ON abp_street_descriptor
  USING btree
  (usrn); 

CREATE INDEX idx_street_descriptor_townname
  ON abp_street_descriptor
  USING btree
  (town_name); 

CREATE INDEX idx_street_descriptor_locality_name
  ON abp_street_descriptor
  USING btree
  (locality_name); 

CREATE INDEX idx_street_description_street_description
  ON abp_street_descriptor
  USING btree
  (street_description); 
  
ALTER TABLE abp_street_descriptor ADD PRIMARY KEY (usrn); --NOT UNIQUE;

 ALTER TABLE abp_street_descriptor SET WITH OIDS;

 -- organisation


CREATE INDEX idx_organisation_organisation
  ON abp_organisation
  USING btree
  (organisation);  

CREATE INDEX idx_organisation_uprn
  ON abp_organisation
  USING btree
  (uprn); 

 ALTER TABLE abp_organisation ADD PRIMARY KEY (org_key); 
 
 ALTER TABLE abp_organisation SET WITH OIDS;


