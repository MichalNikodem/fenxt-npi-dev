TRUNCATE TABLE wrk_out_ProjectBudgets;
INSERT /*+ direct */ into wrk_out_ProjectBudgets
								(
								TenantId,
								PeriodAmount,
								ProjectBudgetId,
								ProjectId,
								AccountId,
								FiscalPeriodId,
								ScenarioId,
								_sys_is_deleted,
								_sys_hash
								)

SELECT

TenantId,
PeriodAmount,
ProjectBudgetId,
ProjectId,
AccountId,
FiscalPeriodId,
ScenarioId,
FALSE _sys_is_deleted,
MD5 (
        COALESCE(( PeriodAmount )::VARCHAR(1000),'') || '|' ||
        COALESCE(( ProjectId )::VARCHAR(1000),'')
 	) as _sys_hash

FROM (
		select

		    pb.TenantId as "TenantId"
			,cast(pbd.Amount as decimal(19,2)) as "PeriodAmount"
			--,GoodData_Attr(coalesce(pb.ProjectBudgetId,'0')||'-'||pb.AccountId||'-'||pbd.FiscalPeriodId||'-'||pb.ScenarioId) as "ProjectBudgetId"
			,GoodData_Attr(pb.ProjectBudgetId) as "ProjectBudgetId"
			,GoodData_Attr(pb.ProjectId)  as "ProjectId"
			,GoodData_Attr(pb.AccountId)  as "AccountId"
			,GoodData_Attr(pbd.FiscalPeriodId)  as "FiscalPeriodId"
			,GoodData_Attr(pb.ScenarioId) as "ScenarioId"
		from tmp_ProjectBudgets pb
		join tmp_ProjectBudgetDetail pbd
		  on pb.ProjectBudgetId = pbd.ProjectBudgetId
		 and pb.TenantId = pbd.TenantId
	) as ProjectBudget ;

INSERT /*+ direct */ into wrk_out_ProjectBudgets
								(
								TenantId,
								PeriodAmount,
								ProjectBudgetId,
								ProjectId,
								AccountId,
								FiscalPeriodId,
								ScenarioId,
								_sys_is_deleted,
								_sys_hash
								)

SELECT

TenantId,
PeriodAmount,
ProjectBudgetId,
ProjectId,
AccountId,
FiscalPeriodId,
ScenarioId,
FALSE as _sys_is_deleted,
MD5 (
        COALESCE(( PeriodAmount )::VARCHAR(1000),'') || '|' ||
        COALESCE(( ProjectId )::VARCHAR(1000),'')
 	) as _sys_hash

FROM (

		select

		    p.TenantId as "TenantId",
			cast(0 as decimal(19,2)) as "PeriodAmount",
			--GoodData_Attr(coalesce(p.ProjectId,'0')||'-'||'#'||'-'|| FP.Id ||'#-1'||'-'||'-1') as "ProjectBudgetId",
			GoodData_Attr(p.ProjectId)  as "ProjectBudgetId",
			GoodData_Attr(p.ProjectId)  as "ProjectId",
			GoodData_Attr(null)  as "AccountId",
			GoodData_Attr(FP.Id)  as "FiscalPeriodId",
			GoodData_Attr('-1') as "ScenarioId"
		from stg_csv_project_merge p
		join (select min(FiscalPeriodId) as "Id", TenantId from stg_csv_FiscalPeriod_merge group by TenantId) FP
		on p.TenantId=fp.TenantId
		WHERE p._sys_is_deleted = FALSE
     ) as ProjectBudget
;

#{consolidate(param_definition_file="out_projectbudgets.json")}