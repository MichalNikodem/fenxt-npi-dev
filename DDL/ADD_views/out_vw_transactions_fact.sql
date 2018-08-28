CREATE OR REPLACE VIEW out_vw_transactions_fact AS
SELECT
	(CASE WHEN (t.TranDistributionId IS NULL) THEN ''::varchar ELSE (t.TranDistributionId)::varchar END)::VARCHAR(512) as "cp__transactiondistributionid",
	(CASE WHEN (t.DateAdded < '1900-01-01'::date) THEN '1900-01-01'::date WHEN (t.DateAdded > '2050-01-01'::date) THEN '2050-01-01'::date ELSE t.DateAdded END)::DATE as "d__dateadded",
	(CASE WHEN (t.DateChanged < '1900-01-01'::date) THEN '1900-01-01'::date WHEN (t.DateChanged > '2050-01-01'::date) THEN '2050-01-01'::date ELSE t.DateChanged END)::DATE as "d__datechanged",
	(t.TDAmount)::NUMERIC(15,2) as "f__transactionamount",
	(CASE WHEN (t.AccountId IS NULL) THEN ''::varchar ELSE (t.AccountId)::varchar END)::VARCHAR(512) as "r__accounts",
	(CASE WHEN (t.FiscalPeriodId IS NULL) THEN ''::varchar ELSE (t.FiscalPeriodId)::varchar END)::VARCHAR(512) as "r__fiscalperiods",
	(CASE WHEN (coalesce(t.BatchId, 0) IS NULL) THEN ''::varchar ELSE (coalesce(t.BatchId, 0))::varchar END)::VARCHAR(512) as "r__glbatches",
	(CASE WHEN (coalesce(t.GrantId, 0) IS NULL) THEN ''::varchar ELSE (coalesce(t.GrantId, 0))::varchar END)::VARCHAR(512) as "r__grants",
	(CASE WHEN (coalesce(t.Projectid, (-1)) IS NULL) THEN ''::varchar ELSE (coalesce(t.Projectid, (-1)))::varchar END)::VARCHAR(512) as "r__projects",
	(CASE WHEN (t.TranDistributionId IS NULL) THEN ''::varchar ELSE (t.TranDistributionId)::varchar END)::VARCHAR(512) as "r__transactions_attr",
	t.TenantId::VARCHAR(128) as x__client_id
  --, _sys_updated_at::TIMESTAMP as "x__timestamp",
  --_sys_is_deleted::BOOLEAN as "x__deleted"
FROM out_Transactions t
WHERE (t._sys_is_deleted = false)
UNION ALL
SELECT
	(CASE WHEN ((1000000000000 + st.SummaryId) IS NULL) THEN ''::varchar ELSE ((1000000000000 + st.SummaryId))::varchar END)::VARCHAR(512) as "cp__transactiondistributionid",
	NULL::DATE as "d__dateadded",
	NULL::DATE as "d__datechanged",
	(st.Amount)::NUMERIC(15,2) as "f__transactionamount",
	(CASE WHEN (st.AccountId IS NULL) THEN ''::varchar ELSE (st.AccountId)::varchar END)::VARCHAR(512) as "r__accounts",
	(CASE WHEN (st.FiscalPeriodId IS NULL) THEN ''::varchar ELSE (st.FiscalPeriodId)::varchar END)::VARCHAR(512) as "r__fiscalperiods",
	'0'::VARCHAR(512) as "r__glbatches",
	'0'::VARCHAR(512) as "r__grants",
	(CASE WHEN (coalesce(st.ProjectId, (-1)) IS NULL) THEN ''::varchar ELSE (coalesce(st.ProjectId, (-1)))::varchar END)::VARCHAR(512) as "r__projects",
	(CASE WHEN ((1000000000000 + st.SummaryId) IS NULL) THEN ''::varchar ELSE ((1000000000000 + st.SummaryId))::varchar END)::VARCHAR(512) as "r__transactions_attr",
	st.TenantId::VARCHAR(128) as x__client_id
  --, _sys_updated_at::TIMESTAMP as "x__timestamp",
  --_sys_is_deleted::BOOLEAN as "x__deleted"
FROM stg_csv_SummarizedTransaction_merge st
WHERE (st._sys_is_deleted = false)
;