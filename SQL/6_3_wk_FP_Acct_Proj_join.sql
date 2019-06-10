truncate table wk_FiscalPeriod_Scenario_Join;
insert /*+ direct */ into wk_FiscalPeriod_Scenario_Join
select pb.TenantId, 
pb.projectid, 
ab.AccountId, 
to_char(BS.ScenarioId) as "ScenarioId",
abd.FiscalPeriodId
	from stg_csv_AccountBudget_merge ab
	join stg_csv_AccountBudgetDetail_merge abd
		on abd.AccountBudgetId = ab.AccountBudgetId and abd.TenantId = ab.TenantId
	join stg_csv_budgetscenario_merge bs
		on bs.BudgetScenarioId = ab.BudgetScenarioId and bs.TenantId = ab.TenantId
	join stg_csv_tableentry_merge te
		on bs.ScenarioId = te.TableEntryId and te.CodeTableId = 124 and te.TenantId = ab.TenantId and te._sys_is_deleted = false
	join stg_csv_ProjectBudget_merge pb
		on pb.AccountBudgetId = ab.AccountBudgetId and pb.TenantId = ab.TenantId
	join stg_csv_ProjectBudgetDetail_merge pbd
		on pbd.ProjectBudgetId = pb.ProjectBudgetId and pbd.TenantId = ab.TenantId
	where pbd.FiscalPeriodId = abd.FiscalPeriodId
	group by pb.projectid, ab.AccountId, BS.ScenarioId, abd.FiscalPeriodId, pb.TenantId
;
select analyze_statistics('wk_FiscalPeriod_Scenario_Join');

