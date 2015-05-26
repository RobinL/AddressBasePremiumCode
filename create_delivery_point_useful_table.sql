drop table if exists abp_useful_dpa;
create table abp_useful_dpa as 
SELECT
uprn,
organisation_name,
department_name,
postcode,
building_number,
geom
,
(
 CASE WHEN department_name IS NOT NULL THEN department_name || ', ' ELSE '' END
 || CASE WHEN organisation_name IS NOT NULL THEN organisation_name || ', ' ELSE '' END
 || CASE WHEN sub_building_name IS NOT NULL THEN sub_building_name || ', ' ELSE '' END
 || CASE WHEN building_name IS NOT NULL THEN building_name || ', ' ELSE '' END
 || CASE WHEN building_number IS NOT NULL THEN building_number || ' ' ELSE '' END
 || CASE WHEN rm_po_box_number IS NOT NULL THEN 'PO BOX ' || rm_po_box_number || ', ' ELSE '' END
 || CASE WHEN dependent_thoroughfare_name IS NOT NULL THEN dependent_thoroughfare_name || ', ' ELSE '' END
 || CASE WHEN thoroughfare_name IS NOT NULL THEN thoroughfare_name || ', ' ELSE '' END
 || CASE WHEN double_dependent_locality IS NOT NULL THEN double_dependent_locality || ', ' ELSE '' END
 || CASE WHEN dependent_locality IS NOT NULL THEN dependent_locality  || ', ' ELSE '' END
 || CASE WHEN post_town IS NOT NULL THEN post_town || ', ' ELSE '' END
 || postcode
) AS dpa_single_address_label
FROM abp_delivery_point as d
left join abp_blpu as b
on d.uprn=b.uprn;

CREATE INDEX idx_abp_useful_dpa_postcode
  ON abp_useful_dpa
  USING btree
  (postcode);  

CREATE INDEX idx_abp_useful_dpa_uprn
  ON abp_useful_dpa
  USING btree
  (uprn); 

CREATE INDEX idx_abp_useful_dpa_geom
  ON abp_useful_dpa
  USING gist
  (geom); 

CREATE INDEX idx_abp_useful_dpa_fts_address ON abp_useful_dpa 
USING gin(to_tsvector('english', dpa_single_address_label));

