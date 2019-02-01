CREATE OR REPLACE VIEW out_vw_transactionscenarios AS
SELECT
	(CASE WHEN ((((out_TransactionScenario.TransactionDistributionId)::varchar || '#'::varchar(1)) || coalesce(out_TransactionScenario.ScenarioId, '-1'::varchar(11))) IS NULL) THEN ''::varchar ELSE (((out_TransactionScenario.TransactionDistributionId)::varchar || '#'::varchar(1)) || coalesce(out_TransactionScenario.ScenarioId, '-1'::varchar(11))) END)::VARCHAR(512) as "cp__transactionscenarioid",
	(CASE WHEN (out_TransactionScenario.AccountId IS NULL) THEN ''::varchar ELSE (out_TransactionScenario.AccountId)::varchar END)::VARCHAR(512) as "r__accounts",
	(CASE WHEN (out_TransactionScenario.ScenarioId IS NULL) THEN ''::varchar ELSE out_TransactionScenario.ScenarioId END)::VARCHAR(512) as "r__budgetscenario",
	(CASE WHEN (out_TransactionScenario.FiscalPeriodId IS NULL) THEN ''::varchar ELSE (out_TransactionScenario.FiscalPeriodId)::varchar END)::VARCHAR(512) as "r__fiscalperiods",
	(CASE WHEN (out_TransactionScenario.TransactionDistributionId IS NULL) THEN ''::varchar ELSE (out_TransactionScenario.TransactionDistributionId)::varchar END)::VARCHAR(512) as "r__transactions_attr",
	TenantId::VARCHAR(128) as x__client_id
  --, _sys_updated_at::TIMESTAMP as "x__timestamp",
  --_sys_is_deleted::BOOLEAN as "x__deleted"
FROM out_TransactionScenario
WHERE (out_TransactionScenario._sys_is_deleted = false)
;