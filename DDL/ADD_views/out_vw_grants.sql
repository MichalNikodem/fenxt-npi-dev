CREATE OR REPLACE VIEW out_vw_grants AS
SELECT
	Description::VARCHAR(512) 	as "a__grantdescription",
	UserId::VARCHAR(512) 				as "a__grantsgrantid",
	Status::VARCHAR(512) 				as "a__grantstatus",
	Type::VARCHAR(512) 					as "a__granttype",
	GrantId::VARCHAR(512) 			as "cp__grantid",
	DateAdded::DATE 						as "d__dateadded",
	EndDate::DATE 							as "d__grantenddate",
	StartDate::DATE 						as "d__grantstartdate",
	GrantAmount::NUMERIC(15,2) 	as "f__grantamount",
	TenantId::VARCHAR(128) 			as x__client_id
FROM out_Grants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Grants')

UNION ALL

SELECT
	''::VARCHAR(512) as "a__grantdescription",
	GoodData_Attr('0')::VARCHAR(512) as "a__grantsgrantid",
	''::VARCHAR(512) as "a__grantstatus",
	''::VARCHAR(512) as "a__granttype",
	GoodData_Attr(0)::VARCHAR(512) as "cp__grantid",
	NULL::DATE as "d__dateadded",
	NULL::DATE as "d__grantenddate",
	NULL::DATE as "d__grantstartdate",
	NULL::NUMERIC(15,2) as "f__grantamount",
	TenantId::VARCHAR(128) AS x__client_id
from out_Tenants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;