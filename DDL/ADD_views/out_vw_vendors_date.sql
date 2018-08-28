CREATE OR REPLACE VIEW out_vw_vendors_date AS
SELECT
	VendorDateId::VARCHAR(512) as "cp__venderdateid",
	DateAdded::DATE as "d__dateadded",
	DateChanged::DATE as "d__datechanged",
	Dummy::NUMERIC(15,2) as "f__dummy",
	VendorId::VARCHAR(512) as "r__vendors",
	TenantId::VARCHAR(128) as x__client_id
FROM out_Vendors
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Vendors')
;