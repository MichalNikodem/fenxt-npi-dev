drop table if exists out_AccountBudgets_fact;
drop table if exists wrk_out_AccountBudgets_fact;
drop table if exists wrk_out_AccountBudgets_fact_diff;

CREATE TABLE out_AccountBudgets_fact
(
    TenantId varchar(512) encoding rle,
    AccountBudgetAmount varchar(512),
    AccountId varchar(512),
    FiscalPeriodId varchar(512),
    AccountBudgetFactId varchar(512),
    AccountBudgetAttrId varchar(512),
    ScenarioId varchar(512),
    _sys_hash varchar(32),
    _sys_is_deleted boolean encoding rle,
    _sys_updated_at timestamp
)  ORDER BY TenantId,
            AccountBudgetFactId,
            _sys_hash,
            _sys_is_deleted

SEGMENTED BY hash(TenantId,AccountBudgetFactId) ALL NODES;

CREATE TABLE wrk_out_AccountBudgets_fact LIKE out_AccountBudgets_fact INCLUDING PROJECTIONS;
CREATE TABLE wrk_out_AccountBudgets_fact_diff LIKE out_AccountBudgets_fact INCLUDING PROJECTIONS;