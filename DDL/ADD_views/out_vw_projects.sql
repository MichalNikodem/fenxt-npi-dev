CREATE OR REPLACE VIEW out_vw_projects AS
SELECT
	AddedByUserName::VARCHAR(512) as "a__addedbyusername",
	Department::VARCHAR(512) as "a__department",
	ProjectId::VARCHAR(512) as "a__description",
	Division::VARCHAR(512) as "a__division",
	Location::VARCHAR(512) as "a__location",
	ProjectStatus::VARCHAR(512) as "a__projectstatus",
	ProjectType::VARCHAR(512) as "a__projecttype",
	UserId::VARCHAR(512) as "a__projectuserid",
	ProjectId::VARCHAR(512) as "cp__projectid",
	AddedByUserNameLabel::VARCHAR(512) as "l__addedbyusername__addedbyuserlabel",
	Description::VARCHAR(512) as "l__description__projectdescriptionlabel",
	GoodData_Attr('{"state":"ledger.project.detail","id":'||ProjectId||'}')::VARCHAR(512) as "l__projectuserid__useridhyperlink",
	TenantId::VARCHAR(128) as x__client_id
FROM out_Projects
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Projects')

UNION ALL

SELECT
	GoodData_Attr('')::VARCHAR(512) AS "a__addedbyusername",
	GoodData_Attr('')::VARCHAR(512) AS "a__department",
	GoodData_Attr(-2)::VARCHAR(512) AS "a__description",
	GoodData_Attr('')::VARCHAR(512) AS "a__division",
	GoodData_Attr('')::VARCHAR(512) AS "a__location",
	GoodData_Attr('Active')::VARCHAR(512) AS "a__projectstatus",
	GoodData_Attr('')::VARCHAR(512) AS "a__projecttype",
	GoodData_Attr('')::VARCHAR(512) AS "a__projectuserid",
	GoodData_Attr(-2)::VARCHAR(512) AS "cp__projectid",
	GoodData_Attr('')::VARCHAR(512) AS "l__addedbyusername__addedbyuserlabel",
	GoodData_Attr('')::VARCHAR(512) AS "l__description__projectdescriptionlabel",
	GoodData_Attr('')::VARCHAR(512) AS "l__projectuserid__useridhyperlink",
	TenantId::VARCHAR(128) as x__client_id
from out_Tenants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;