CREATE OR REPLACE VIEW out_vw_transactionprojectscenarios AS
SELECT
	((out_TransactionProjectScenario.TransactionAttrDistributionId || '#'::varchar(1)) || out_TransactionProjectScenario.ScenarioId)::VARCHAR(512) as "cp__transactionprojectscenarioid",
	AccountId::VARCHAR(512) as "r__accounts",
	ScenarioId::VARCHAR(512) as "r__budgetscenario",
	FiscalPeriodId::VARCHAR(512) as "r__fiscalperiods",
	ProjectId::VARCHAR(512) as "r__projects",
	TransactionAttrDistributionId::VARCHAR(512) as "r__transactions_attr",
	TenantId::VARCHAR(128) as x__client_id
FROM out_TransactionProjectScenario
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_TransactionProjectScenario')
;