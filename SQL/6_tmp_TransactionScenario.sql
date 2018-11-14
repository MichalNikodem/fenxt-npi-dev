truncate table wrk_tmp_transaction_scenario;
insert /*+ direct*/ into wrk_tmp_transaction_scenario
select   ab.AccountId,
        to_char(BS.ScenarioId) as ScenarioId,
        abd.FiscalPeriodId,
        ab.tenantid
    from stg_csv_ACCOUNTBUDGET_merge ab
    join stg_csv_AccountBudgetDetail_merge abd on Ab.ACCOUNTBUDGETId = abd.ACCOUNTBUDGETId and ab.tenantid=abd.tenantid and ab._sys_is_deleted=false and abd._sys_is_deleted=false
    join stg_csv_BUDGETSCENARIO_merge BS on ab.BUDGETSCENARIOID = BS.BUDGETSCENARIOID and ab.tenantid = bs.tenantid and bs._sys_is_deleted=false
    join stg_csv_TABLEENTRy_merge TE on BS.ScenarioId = TE.TABLEENTRyID and bs.tenantid = te.tenantid and te._sys_is_deleted=false
    where te.CodeTableId = 124;

select analyze_statistics('wrk_tmp_transaction_scenario');

truncate table wrk_tmp_transaction_scenario_diff;

insert /*+ direct*/ into wrk_tmp_transaction_scenario_diff (AccountId,ScenarioId,FiscalPeriodId,tenantid)
select distinct a.AccountId,a.ScenarioId,a.FiscalPeriodId,a.tenantid
FROM "wrk_tmp_transaction_scenario" a
LEFT JOIN (
    SELECT aa."tenantid",aa."AccountId",aa."FiscalPeriodId",aa."ScenarioId"
    FROM "wrk_tmp_transaction_scenario" aa
    JOIN "tmp_transaction_scenario" bb
    ON
        bb."tenantid" = aa."tenantid" AND bb."AccountId" = aa."AccountId" AND bb."FiscalPeriodId" = aa."FiscalPeriodId" AND bb."ScenarioId" = aa."ScenarioId"
            AND
        bb."_sys_is_deleted" = false
) b ON a."tenantid" = b."tenantid" AND a."AccountId" = b."AccountId" AND a."FiscalPeriodId" = b."FiscalPeriodId" AND a."ScenarioId" = b."ScenarioId"
WHERE b."tenantid" IS NULL;

select analyze_statistics('wrk_tmp_transaction_scenario_diff');

MERGE /* +direct */ INTO tmp_transaction_scenario o
USING wrk_tmp_transaction_scenario_diff temp
ON (
    o."tenantid" = temp."tenantid" AND o."AccountId" = temp."AccountId" AND o."FiscalPeriodId" = temp."FiscalPeriodId" AND o."ScenarioId" = temp."ScenarioId"
)
WHEN MATCHED THEN UPDATE SET
    AccountId = temp.AccountId,
    ScenarioId = temp.ScenarioId,
    FiscalPeriodId = temp.FiscalPeriodId,
    tenantid = temp.tenantid,
    _sys_is_deleted = false,
    _sys_updated_at = now()
WHEN NOT MATCHED THEN INSERT
    (
        AccountId,
        ScenarioId,
        FiscalPeriodId,
        tenantid,
        _sys_is_deleted,
        _sys_updated_at
    )
    VALUES (
        temp.AccountId,
        temp.ScenarioId,
        temp.FiscalPeriodId,
        temp.tenantid,
        false,
        now()
    );


update tmp_transaction_scenario a
   set _sys_is_deleted = true,
       _sys_updated_at = now()
where not exists
       (select 1 from wrk_tmp_transaction_scenario b where a.TenantId=b.TenantId
and a.AccountId=b.AccountId
and a.FiscalPeriodId=b.FiscalPeriodId
and a.ScenarioId=b.ScenarioId
       );

select analyze_statistics('tmp_transaction_scenario');