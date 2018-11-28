CREATE OR REPLACE VIEW out_vw_bankreconciliationhistory AS
SELECT
	AddedByUserId::VARCHAR(512) as "a__bankreconciliationhistoryaddedbyuserid",
	BankReconciliationId::VARCHAR(512) as "cp__bankreconciliationhistoryid",
	ReconciliationDate::DATE as "d__reconciliationdate",
	ReconciliationBalance::NUMERIC(15,2) as "f__bankreconciliationhistory",
	AddedByUserName::VARCHAR(512) as "l__bankreconciliationhistoryaddedbyuserid__bankreconciliationhistoryaddedbyusername",
	BankId::VARCHAR(512) as "r__banks",
	TenantId::VARCHAR(128) as x__client_id
FROM out_BankReconciliationHistory
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_BankReconciliationHistory')
;