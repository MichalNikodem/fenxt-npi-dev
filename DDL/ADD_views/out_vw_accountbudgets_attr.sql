CREATE OR REPLACE VIEW out_vw_accountbudgets_attr AS
select
    AccountBudgetAttrId::VARCHAR(512) as cp__accountbudgetattrid,
    ScenarioId::VARCHAR(512) as r__budgetscenario,
    AccountBudgetId::VARCHAR(512) as a__accountbudgetid,
    TenantId::VARCHAR(128) as x__client_id
FROM out_AccountBudgets_attr a;