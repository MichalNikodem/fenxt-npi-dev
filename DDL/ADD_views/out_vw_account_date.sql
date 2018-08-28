CREATE OR REPLACE VIEW out_vw_account_date AS
SELECT
	AccountDateId::VARCHAR(512) as "cp__accountdateid",
	DateAdded::DATE as "d__dateadded",
	DateChanged::DATE as "d__datechanged",
	Dummy::NUMERIC(15,2) as "f__dummy",
	AccountId::VARCHAR(512) as "r__accounts",
	TenantId::VARCHAR(128) as x__client_id
FROM out_Accounts
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Accounts')
;