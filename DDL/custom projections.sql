DROP PROJECTION stg_csv_ProjectBudgetDetail_groupby;
CREATE PROJECTION stg_csv_ProjectBudgetDetail_groupby /*+createtype(P)*/
(
 TenantId,
 ProjectBudgetId,
 FiscalPeriodId,
 Amount,
 _sys_is_deleted
)
AS
 SELECT stg_csv_ProjectBudgetDetail_merge.TenantId,
        stg_csv_ProjectBudgetDetail_merge.ProjectBudgetId,
        stg_csv_ProjectBudgetDetail_merge.FiscalPeriodId,
        stg_csv_ProjectBudgetDetail_merge.Amount,
        stg_csv_ProjectBudgetDetail_merge."_sys_is_deleted"
 FROM stg_csv_ProjectBudgetDetail_merge
 ORDER BY stg_csv_ProjectBudgetDetail_merge.TenantId,
          stg_csv_ProjectBudgetDetail_merge.ProjectBudgetId,
          stg_csv_ProjectBudgetDetail_merge.FiscalPeriodId

SEGMENTED BY hash(stg_csv_ProjectBudgetDetail_merge.TenantId, stg_csv_ProjectBudgetDetail_merge.ProjectBudgetId,stg_csv_ProjectBudgetDetail_merge.FiscalPeriodId) ALL NODES KSAFE 1;
