CREATE OR REPLACE VIEW out_vw_project_date AS
SELECT
	ProjectDateId::VARCHAR(512) as "cp__projectdateid",
	DateAdded::DATE as "d__dateadded",
	DateChanged::DATE as "d__datechanged",
	Dummy::NUMERIC(15,2) as "f__dummy",
	ProjectId::VARCHAR(512) as "r__projects",
	TenantId::VARCHAR(128) as x__client_id
FROM out_projects
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Projects')

UNION ALL

SELECT
	GoodData_Attr(0)::VARCHAR(512) as "cp__projectdateid",
	NULL::DATE as "d__dateadded",
	NULL::DATE as "d__datechanged",
	GoodData_Attr(1)::NUMERIC(15,2)  as "f__dummy",
	GoodData_Attr(-2)::VARCHAR(512) as "r__projects",
	TenantId::VARCHAR(128) as x__client_id
from out_Tenants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;