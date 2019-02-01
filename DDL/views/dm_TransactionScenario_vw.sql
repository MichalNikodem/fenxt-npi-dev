 create or replace view dm_TransactionScenario as select
--_sys_transform_id,
TenantId,
GoodData_Attr(to_char(TransactionDistributionId)||'#'||isnull(ScenarioId, '-1')) as "TransactionScenarioId",
GoodData_Attr(TransactionDistributionId) as TransactionDistributionId,
GoodData_Attr(ScenarioId) as ScenarioId,
GoodData_Attr(FiscalPeriodId) as FiscalPeriodId,
GoodData_Attr(AccountId) as AccountId
from out_TransactionScenario
where _sys_is_deleted=false;