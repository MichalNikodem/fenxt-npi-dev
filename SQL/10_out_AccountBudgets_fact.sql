truncate table wrk_out_AccountBudgets_fact;
insert /*+ direct */ into wrk_out_AccountBudgets_fact 
                                    (
                                    TenantId,
                                    AccountBudgetAmount,
                                    AccountId,
                                    FiscalPeriodId,
                                    AccountBudgetFactId,
                                    ScenarioId,
                                    _sys_is_deleted,
                                    _sys_hash
                                    )

SELECT 
TenantId,
AccountBudgetAmount,
AccountId,
FiscalPeriodId,
AccountBudgetFactId,
ScenarioId,
_sys_is_deleted,
MD5 (
        COALESCE(( AccountBudgetAmount )::VARCHAR(1000),'') || '|' ||
        COALESCE(( AccountId )::VARCHAR(1000),'') || '|' ||
        COALESCE(( FiscalPeriodId )::VARCHAR(1000),'') || '|' ||
        COALESCE(( ScenarioId )::VARCHAR(1000),'') 
    ) as _sys_hash

FROM (

        SELECT
            abd.TenantId,
            cast(abd.Amount as decimal(19,2)) as "AccountBudgetAmount",
            ab.AccountId::VARCHAR(512)  as "AccountId",
            abd.FiscalPeriodId::VARCHAR(512) as "FiscalPeriodId",
            abd.AccountBudgetDetailId::VARCHAR(512) as "AccountBudgetFactId",
            BS.ScenarioId::VARCHAR(512) as "ScenarioId",
            FALSE as _sys_is_deleted
        from stg_csv_accountbudgetdetail_merge abd
        join stg_csv_accountbudget_merge ab
            on abd.AccountBudgetId = ab.AccountBudgetId 
            and abd.TenantId = ab.TenantId
        join stg_csv_budgetscenario_merge bs
            on bs.BudgetScenarioId = ab.BudgetScenarioId 
            and bs.TenantId = abd.TenantId
        join stg_csv_tableentry_merge te
            on bs.ScenarioId = te.TableEntryId 
            and te.CodeTableId = 124 
            and te.TenantId = abd.TenantId  
            and te._sys_is_deleted = false

        union all

        SELECT

            a.tenantId,
            cast(0 as decimal(19,2)) as "AccountBudgetAmount",
            a.AccountId::VARCHAR(512)  as "AccountId",
            FP.Id::VARCHAR(512) as "FiscalPeriodId",
            (a.AccountId || '#' || FP.ID || '#-1')::VARCHAR(512) as "AccountBudgetFactId",
            '-1'::VARCHAR(512) as "ScenarioId",
            FALSE as _sys_is_deleted
        from stg_csv_account_merge a
        join (SELECT 
             min(FiscalPeriodId) as "Id", 
             TenantId 
             from stg_csv_FiscalPeriod_merge 
             group by TenantId) FP
            on a.TenantId=fp.TenantId

    ) as AccountBudgetFact
;

#{consolidate(param_definition_file="out_accountbudgets_fact.json")}