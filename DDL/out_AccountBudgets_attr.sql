drop table if exists out_AccountBudgets_attr CASCADE;
drop table if exists wrk_out_AccountBudgets_attr CASCADE;
drop table if exists wrk_out_AccountBudgets_attr_diff CASCADE;

CREATE TABLE out_AccountBudgets_attr 

(
    TenantId varchar(512) encoding rle,
    AccountBudgetAttrId varchar(512),
    IncorrectScenarioId varchar(512),
    ScenarioId varchar(512),
    AccountBudgetId varchar(512),
    _sys_is_deleted boolean,
    _sys_hash varchar(32),
    _sys_updated_at timestamp
)  ORDER BY TenantId,
			AccountBudgetAttrId,
			_sys_hash,
			_sys_is_deleted

SEGMENTED BY hash(out_AccountBudgets_attr.TenantId,out_AccountBudgets_attr.AccountBudgetAttrId) ALL NODES ;

CREATE TABLE wrk_out_AccountBudgets_attr LIKE out_AccountBudgets_attr INCLUDING PROJECTIONS;
CREATE TABLE wrk_out_AccountBudgets_attr_diff LIKE out_AccountBudgets_attr INCLUDING PROJECTIONS;