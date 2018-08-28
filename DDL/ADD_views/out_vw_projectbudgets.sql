CREATE OR REPLACE VIEW out_vw_projectbudgets AS
SELECT
	ProjectBudgetId::VARCHAR(512) as "cp__projectbudgetid",
	PeriodAmount::NUMERIC(15,2) as "f__periodamount",
	ProjectBudgetAmount::NUMERIC(15,2) as "f__projectbudgetamount",
	AccountBudgetAttrId::VARCHAR(512) as "r__accountbudgets_attr",
	AccountId::VARCHAR(512) as "r__accounts",
	FiscalPeriodId::VARCHAR(512) as "r__fiscalperiods",
	ProjectId::VARCHAR(512) as "r__projects",
	TenantId::VARCHAR(128) as x__client_id
FROM out_ProjectBudgets
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_ProjectBudgets')
;