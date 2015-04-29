

drop table if exists abp_useful_gb;

CREATE TABLE abp_useful_gb AS

SELECT  
b.arc_id,
b.uprn,
b.postal_address,
b.logical_status,
c.classification_code,
o.organisation,
l.pao_text, l.pao_start_number, l.pao_start_suffix, l.pao_end_number, l.pao_end_suffix,
l.sao_text, l.sao_start_number, l.sao_start_suffix, l.sao_end_number, l.sao_end_suffix,
s.street_description,
s.locality_name,
s.town_name,
b.postcode_locator,
--attribution from "Xref" table
x.al2_source, x.al2_crossreference, x.topo_source, x.topo_cross_reference,
/*
Concatenate a single GEOGRAPHIC address line label

This code takes into account all possible combinations os pao/sao numbers and suffixes
*/
case when o.organisation != '' then o.organisation||', ' else '' end
||case when l.sao_text != '' then l.sao_text||', ' else '' end
  --Primary Addressable Information----------------------------------------------------------------------------------------------------------
  ||case when l.pao_text != '' then l.pao_text||', ' else '' end
  --case statement for different combinations of the pao start numbers (e.g. if no pao start suffix)
  ||case
        when l.pao_start_number is not null and l.pao_start_suffix = '' and l.pao_end_number is null 
          then l.pao_start_number::varchar(3)||', '       
        when l.pao_start_number is null then '' 
        else l.pao_start_number::varchar(3)||' ' end
  --case statement for different combinations of the pao start suffixes (e.g. if no pao end number)
  ||case
        when l.pao_start_suffix != '' and l.pao_end_number is null then l.pao_start_suffix||', '
        when l.pao_start_suffix != '' and l.pao_end_number is not null then l.pao_start_suffix 
        else '' end
  --Add a '-' between the start and end of the primary address (e.g. only when pao start and pao end)
  ||case when l.pao_end_suffix != '' and l.pao_end_number is not null then '-' else '' end
  --case statement for different combinations of the pao end numbers and pao end suffixes
  ||case 
      when l.pao_end_number is not null and l.pao_end_suffix = '' then l.pao_end_number::varchar(3)||', ' 
      when l.pao_end_number is null then '' 
      else l.pao_end_number::varchar(3) end
  --pao end suffix
  ||case when l.pao_end_suffix != '' then l.pao_end_suffix||', ' else '' end
  --Secondary Addressable Information-------------------------------------------------------------------------------------------------------
  -- ||case when l.sao_text != '' then l.sao_text||', ' else '' end
  --case statement for different combinations of the sao start numbers (e.g. if no sao start suffix)
  ||case
        when l.sao_start_number is not null and l.sao_start_suffix = '' and l.sao_end_number is null 
          then l.sao_start_number::varchar(3)||', '
        when l.sao_start_number is null then '' 
        else l.sao_start_number::varchar(3) end
  --case statement for different combinations of the sao start suffixes (e.g. if no sao end number)
  ||case
        when l.sao_start_suffix != '' and l.sao_end_number is null then l.sao_start_suffix||', '
        when l.sao_start_suffix != '' and l.sao_end_number is not null then l.sao_start_suffix 
        else '' end
  --Add a '-' between the start and end of the secondary address (e.g. only when sao start and sao end)
  ||case when l.sao_end_suffix != '' and l.sao_end_number is not null then '-' else '' end
  --case statement for different combinations of the sao end numbers and sao end suffixes
  ||case 
      when l.sao_end_number is not null and l.sao_end_suffix = '' then l.sao_end_number::varchar(3)||', ' 
      when l.sao_end_number is null then '' 
      else l.sao_end_number::varchar(3) end
  --pao end suffix
  ||case when l.sao_end_suffix != '' then l.sao_end_suffix||', ' else '' end
  --Street Information----------------------------------------------------------------------------------------------------------------------------
  ||case when s.street_description != '' then s.street_description||', ' else '' end    
  --Locality------------------------------------------------------------------------------------------------------------------------------------------
  ||case when s.locality_name != '' then s.locality_name||', ' else '' end
  --Town---------------------------------------------------------------------------------------------------------------------------------------------
  ||case when s.town_name != '' then s.town_name||', ' else '' end
  --Postcode----------------------------------------------------------------------------------------------------------------------------------------
  ||case when b.postcode_locator != '' then b.postcode_locator else '' end
AS geo_single_address_label,
b.geom

 
FROM 
abp_street_descriptor AS s, abp_classification as c,
abp_lpi as l full outer join abp_organisation AS o on (l.uprn = o.uprn),
abp_blpu AS b
--GET AddressLayer2 and TOPO attributes from xRef table onto a single line i.e. per UPRN feature
--We are using a left outer join, in order to pull ALL uprns, frmo BLPU table. I.e. so that all uprns, even those without TOID references, are included
LEFT OUTER JOIN
(SELECT al2.uprn, al2.al2_source, al2.al2_crossreference, topo.topo_source, topo.topo_cross_reference
FROM
  (SELECT uprn, source AS al2_source, cross_reference AS al2_crossreference FROM abp_crossref WHERE source = '7666MA') AS al2,
  (SELECT uprn, source AS topo_source, cross_reference AS topo_cross_reference FROM abp_crossref WHERE source = '7666MT') AS topo
  WHERE al2.uprn = topo.uprn) AS x
ON (b.uprn = x.uprn)

--join tables
WHERE b.uprn = l.uprn
AND l.usrn = s.usrn
AND b.uprn = c.uprn;


CREATE INDEX idx_abp_useful_gb_postcode
  ON abp_useful_gb
  USING btree
  (postcode_locator);  

CREATE INDEX idx_abp_useful_gb_uprn
  ON abp_useful_gb
  USING btree
  (uprn); 

CREATE INDEX idx_abp_useful_gb_geom
  ON abp_useful_gb
  USING gist
  (geom); 

 
