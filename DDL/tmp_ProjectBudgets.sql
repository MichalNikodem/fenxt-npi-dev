CREATE TABLE tmp_ProjectBudgets
(
    TenantId varchar(255) encoding rle,
    ProjectBudgetId int encoding rle,
    ProjectId int,
    AccountId int,
    ProjectBudgetAmount numeric(19,4),
    ScenarioId varchar(255)
) ORDER BY TenantId,
           ProjectBudgetId
SEGMENTED BY hash(TenantId) ALL NODES;
