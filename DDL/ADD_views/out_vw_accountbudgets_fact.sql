CREATE OR REPLACE VIEW out_vw_accountbudgets_fact AS
SELECT
    AccountBudgetFactId::VARCHAR(512) as cp__accountbudgetfactid,
    AccountBudgetAmount::NUMERIC(19,2) as f__accountbudgetamount,
    AccountBudgetAttrId::VARCHAR(512) as r__accountbudgets_attr,
    AccountId::VARCHAR(512) as r__accounts,
    FiscalPeriodId::VARCHAR(512) as r__fiscalperiods,
    TenantId::VARCHAR(128) as x__client_id
FROM out_AccountBudgets_fact
;