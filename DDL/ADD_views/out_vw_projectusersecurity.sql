CREATE OR REPLACE VIEW out_vw_projectusersecurity AS
SELECT
	UserId::VARCHAR(512) as "a__userid",
	ProjectUserSecurityId::VARCHAR(512) as "cp__projectusersecurityid",
	ProjectId::VARCHAR(512) as "r__projects",
	TenantId::VARCHAR(128) as x__client_id
FROM out_ProjectUserSecurity
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ProjectUserSecurity')

UNION ALL

SELECT
	GoodData_Attr(UserId)::VARCHAR(512) as "a__userid",
	GoodData_Attr(UserId||'#0')::VARCHAR(512) as "cp__projectusersecurityid",
	GoodData_Attr('-2')::VARCHAR(512) as "r__projects",
	TenantId::VARCHAR(128) as x__client_id
from stg_csv_User_merge
-- where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;