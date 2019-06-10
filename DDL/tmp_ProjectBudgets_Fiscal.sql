DROP TABLE IF EXISTS tmp_ProjectBudgets_Fiscal;
CREATE TABLE tmp_ProjectBudgets_Fiscal
								(
								TenantId				VARCHAR(255) ENCODING RLE,
								ProjectId				INT,
								AccountId				INT,
								ScenarioId				INT,
								FiscalPeriodId			VARCHAR(255),
								Amount					numeric(19,2)
								)
ORDER BY
TenantId,
ProjectId,
AccountId,
ScenarioId,
FiscalPeriodId

SEGMENTED BY   HASH(tmp_ProjectBudgets_Fiscal.TenantId,
					tmp_ProjectBudgets_Fiscal.ProjectId,
					tmp_ProjectBudgets_Fiscal.AccountId,
					tmp_ProjectBudgets_Fiscal.ScenarioId,
					tmp_ProjectBudgets_Fiscal.FiscalPeriodId) ALL NODES KSAFE 1;
