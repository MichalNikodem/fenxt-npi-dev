truncate table tmp_ProjectBudgets;
insert /*+direct*/ into tmp_ProjectBudgets
select   pb.TenantId as "TenantId"
	,pb.ProjectBudgetId
	,pb.ProjectId  as "ProjectId"
	,pb.AccountId  as "AccountId"
	,pb.Amount as "ProjectBudgetAmount"
	,abs.ScenarioId as "ScenarioId"
from stg_csv_ProjectBudget_merge pb
join wk_AccountBudgetScenario abs
	on pb.AccountBudgetId = abs.AccountBudgetId and pb.TenantId = abs.TenantId
;

select analyze_statistics('tmp_ProjectBudgets');