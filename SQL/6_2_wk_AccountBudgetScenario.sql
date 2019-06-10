truncate table wk_AccountBudgetScenario;
insert /*+ direct*/ into wk_AccountBudgetScenario
select 
   ab.TenantId
  ,ab.AccountId
  ,ab.AccountBudgetId
  ,te.CodeTableId
  ,to_char(bs.ScenarioId) as "ScenarioId"
from stg_csv_AccountBudget_merge ab
join stg_csv_BudgetScenario_merge bs
	on ab.BudgetScenarioId = bs.BudgetScenarioId and ab.TenantId = bs.TenantId
join stg_csv_TableEntry_merge te
	on bs.ScenarioId = te.TableEntryId and ab.TenantId = te.TenantId and te._sys_is_deleted = false
;
select analyze_statistics('wk_AccountBudgetScenario');

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

truncate table tmp_ProjectBudgetDetail;

insert /*+direct*/ into tmp_ProjectBudgetDetail
select TenantId, ProjectBudgetId, FiscalPeriodId, SUM(Amount) 
from stg_csv_ProjectBudgetDetail_merge 
where _sys_is_deleted = FALSE
group by TenantId, ProjectBudgetId, FiscalPeriodId;

select analyze_statistics('tmp_ProjectBudgetDetail');

TRUNCATE TABLE tmp_ProjectBudgets_Fiscal;
INSERT /* direct */ into tmp_ProjectBudgets_Fiscal
								(
								TenantId,
								ProjectId,
								AccountId,
								ScenarioId,
								FiscalPeriodId,
								Amount
								)
select

			 pb.TenantId
			,pb.ProjectId 
			,pb.AccountId 
			,pbd.FiscalPeriodId 
			,pb.ScenarioId 
			,pbd.Amount 
		from tmp_ProjectBudgets pb
		join tmp_ProjectBudgetDetail pbd
		  on pb.ProjectBudgetId = pbd.ProjectBudgetId
		 and pb.TenantId = pbd.TenantId ;

SELECT ANALYZE_STATISTICS('tmp_ProjectBudgets_Fiscal');