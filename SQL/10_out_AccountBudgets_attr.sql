truncate table wrk_out_AccountBudgets_attr ;
insert /*+ direct */ into wrk_out_AccountBudgets_attr 
                                    (
                                    TenantId,
                                    AccountBudgetAttrId,
                                    IncorrectScenarioId,
                                    ScenarioId,
                                    AccountBudgetId,
                                    _sys_is_deleted,
                                    _sys_hash
                                    )

SELECT
TenantId,
AccountBudgetAttrId,
IncorrectScenarioId,
ScenarioId,
AccountBudgetId,
_sys_is_deleted,
MD5 (
        COALESCE(( IncorrectScenarioId )::VARCHAR(1000),'') || '|' ||
        COALESCE(( ScenarioId )::VARCHAR(1000),'') || '|' ||
        COALESCE(( AccountBudgetId )::VARCHAR(1000),'')
    ) as _sys_hash
FROM    (
        select

            abd.TenantId as "TenantId",
            abd.AccountBudgetDetailId::VARCHAR(512) as "AccountBudgetAttrId",
            te.Description::VARCHAR(512) as "IncorrectScenarioId",
            BS.ScenarioId::VARCHAR(512) as "ScenarioId",
            ab.AccountBudgetId::VARCHAR(512) as "AccountBudgetId",
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

        select

            a.tenantId  as "TenantId",
            (a.AccountId || '#' || FP.ID || '#-1')::VARCHAR(512) as "AccountBudgetAttrId" ,
            '-1'::VARCHAR(512) as "IncorrectScenarioId",
            '-1'::VARCHAR(512) as "ScenarioId" ,
            (a.AccountId || '#' || FP.ID || '#-1')::VARCHAR(512) as "AccountBudgetId",
            FALSE as _sys_is_deleted
        from stg_csv_account_merge a
        join    (select
                min(FiscalPeriodId) as "Id",
                TenantId
                from stg_csv_FiscalPeriod_merge
                group by TenantId) FP
                on a.TenantId=fp.TenantId
        union all
        
        select
            TenantId::VARCHAR(128) as "TenantId",
            GoodData_Attr('0') as AccountBudgetAttrId,
            '-1'::VARCHAR(512) as "IncorrectScenarioId",
            GoodData_Attr('-1') as ScenarioId,
            GoodData_Attr('0') as AccountBudgetId,
            FALSE 
        from out_Tenants
        ) as AccountBudgets_attr 
;

#{consolidate(param_definition_file="out_accountbudgets_attr.json")}