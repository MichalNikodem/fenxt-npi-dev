INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BudgetScenario',now(),null);
insert /*+ direct */ into out_BudgetScenario
select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	ab.TenantId as "TenantId",
    GoodData_Attr(BS.ScenarioId) as "ScenarioId",
	GoodData_Attr(te.Description) as "ScenarioDesc"
from stg_csv_AccountBudget_merge ab
join stg_csv_BudgetScenario_merge bs
	on ab.BudgetScenarioId = bs.BudgetScenarioId and ab.TenantId = bs.TenantId
join stg_csv_TableEntry_merge te
	on bs.ScenarioId = te.TableEntryId and bs.TenantId = te.TenantId  and te._sys_is_deleted = false
group by bs.ScenarioId, te.Description, ab.TenantId

;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_BudgetScenario',null,now());
select analyze_statistics('out_BudgetScenario')
;