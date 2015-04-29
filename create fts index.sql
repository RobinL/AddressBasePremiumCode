CREATE INDEX idx_fts_address ON abp_useful_gb 
USING gin(to_tsvector('english', geo_single_address_label));

--
select * from abp_useful_gb 
where to_tsvector('english',geo_single_address_label) @@ 'dorian'