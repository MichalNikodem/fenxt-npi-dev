CREATE OR REPLACE VIEW out_vw_accountbudgets_attr AS
select
    AccountBudgetAttrId::VARCHAR(512) as cp__accountbudgetattrid,
    ScenarioId::VARCHAR(512) as r__budgetscenario,
    AccountBudgetId::VARCHAR(512) as a__accountbudgetid,
    TenantId::VARCHAR(128) as x__client_id
FROM out_AccountBudgets_attr a
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_AccountBudgets_attr')
union all
select
    GoodData_Attr('0') as cp__accountbudgetattrid,
    GoodData_Attr('<No budget>') as r__budgetscenario,
    GoodData_Attr('0') as a__accountbudgetid,
    TenantId::VARCHAR(128) as x__client_id
from out_Tenants
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_Tenants')
;