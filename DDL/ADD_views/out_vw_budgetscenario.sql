CREATE OR REPLACE VIEW out_vw_budgetscenario AS
SELECT
	ScenarioId::VARCHAR(512) as "cp__scenarioid",
	ScenarioDesc::VARCHAR(512) as "l__scenarioid__budgetscenariodesc",
	TenantId::VARCHAR(128) as x__client_id
FROM out_BudgetScenario
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_BudgetScenario')
union all
select
	GoodData_Attr('-1')::VARCHAR(512) as "cp__scenarioid",
	GoodData_Attr('<No budget>')::VARCHAR(512) as "l__scenarioid__budgetscenariodesc",
	TenantId::VARCHAR(128) as x__client_id
from out_Tenants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;