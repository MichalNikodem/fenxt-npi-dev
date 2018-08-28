CREATE OR REPLACE VIEW out_vw_banks_date AS
SELECT
	BankDateId::VARCHAR(512) as "cp__bankdateid",
	DateAdded::DATE as "d__dateadded",
	DateChanged::DATE as "d__datechanged",
	DateLastReconciled::DATE as "d__reconciliationdate",
	ReconciledBalance::NUMERIC(15,2) as "f__dummy",
	BankId::VARCHAR(512) as "r__banks",
	TenantId::VARCHAR(128) as x__client_id
FROM out_Banks
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Banks')

UNION ALL

SELECT
	GoodData_Attr(0)::VARCHAR(512) as "cp__bankdateid",
	NULL::DATE as "d__dateadded",
	NULL::DATE as "d__datechanged",
	NULL::DATE as "d__reconciliationdate",
	GoodData_Attr(1)::NUMERIC(15,2) as "f__dummy",
	GoodData_Attr(-1)::VARCHAR(512) as "r__banks",
	TenantId::VARCHAR(128) as x__client_id
from out_Tenants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;