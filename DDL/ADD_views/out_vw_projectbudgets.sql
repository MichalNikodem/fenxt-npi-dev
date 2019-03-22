CREATE OR REPLACE VIEW out_vw_projectbudgets AS
SELECT
	GoodData_Attr(coalesce(ProjectBudgetId,'0')||'-'||coalesce(AccountId,0)||'-'||FiscalPeriodId||'-'||ScenarioId) as "cp__projectbudgetid",
	PeriodAmount::NUMERIC(15,2) as "f__periodamount",
	AccountId::VARCHAR(512) as "r__accounts",
	FiscalPeriodId::VARCHAR(512) as "r__fiscalperiods",
	ProjectId::VARCHAR(512) as "r__projects",
	ScenarioId::varchar(512) AS r__budgetscenario,
	TenantId::VARCHAR(128) as x__client_id
FROM out_ProjectBudgets
;