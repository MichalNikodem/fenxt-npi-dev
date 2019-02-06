INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionProjectScenario',now(),null);
insert /*+ direct */ into out_TransactionProjectScenario
	select
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 null--GoodData_Attr(t.TranDistributionId||'#'||pb.ScenarioId) as "TransactionScenarioId"
	,GoodData_Attr(pb.ProjectId) as "ProjectId"
	,GoodData_Attr(t.TranDistributionId) as "TransactionAttrDistributionId"
	,GoodData_Attr(pb.scenarioid) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from out_transactions t
join wk_FiscalPeriod_Scenario_Join pb on pb.projectid = t.projectid and pb.AccountId = t.AccountId and pb.TenantId = t.TenantId
 and t.FiscalPeriodId = pb.FiscalPeriodId
where t._sys_is_deleted = false
;

insert /*+ direct */ into out_TransactionProjectScenario
select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 null--GoodData_Attr((1000000000000 + t.SummaryId)||'#'||pb.ScenarioId) as "TransactionScenarioId"
	,GoodData_Attr(pb.ProjectId) as "ProjectId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionAttrDistributionId"
	,GoodData_Attr(pb.scenarioid) as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from  stg_csv_SummarizedTransaction_merge t
join wk_FiscalPeriod_Scenario_Join pb on pb.projectid = t.projectid and pb.AccountId = t.AccountId and pb.TenantId = t.TenantId
;

insert /*+ direct */ into out_TransactionProjectScenario
select 
	${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
	t.TenantId as "TenantId",
	 null--GoodData_Attr((1000000000000 + t.SummaryId)||'#-1') as "TransactionScenarioId"
	,GoodData_Attr(NVL(t.ProjectId,'-2')) as "ProjectId"
	,GoodData_Attr((1000000000000 + t.SummaryId)) as "TransactionAttrDistributionId"
	,GoodData_Attr('-1') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from  stg_csv_SummarizedTransaction_merge t
;

insert /*+ direct */ into out_TransactionProjectScenario
select 
     ${TRANSFORM_ID['TRANSFORM_ID']} as _sys_transform_id,
     t.TenantId as "TenantId",
	 null--GoodData_Attr(t.TranDistributionId||'#-1') as "TransactionScenarioId"
	,GoodData_Attr(NVL(t.ProjectId,'-2')) as "ProjectId"
	,GoodData_Attr(t.TranDistributionId) as "TransactionAttrDistributionId"
	,GoodData_Attr('-1') as "ScenarioId"
	,GoodData_Attr(t.FiscalPeriodId) as "FiscalPeriodId"
	,GoodData_Attr(t.AccountId) as "AccountId"
from out_transactions t
where _sys_is_deleted = false

;
INSERT INTO _sys_transform_id (id,entity,ts_start,ts_end) VALUES (${TRANSFORM_ID['TRANSFORM_ID']},'dm_TransactionProjectScenario',null,now());
select analyze_statistics('out_TransactionProjectScenario')
;