CREATE OR REPLACE VIEW out_vw_glbatches_fact AS
SELECT
	BatchFactId::VARCHAR(512) as "cp__batchid",
	DateApproved::DATE as "d__approveddate",
	DateAdded::DATE as "d__dateadded",
	DateChanged::DATE as "d__datechanged",
	DateDeleted::DATE as "d__deleteddate",
	CreditAmount::NUMERIC(15,2) as "f__creditamount",
	DebitAmount::NUMERIC(15,2) as "f__debitamount",
	BatchId::VARCHAR(512) as "r__glbatches",
	TenantId::VARCHAR(128) as x__client_id
FROM out_GLBatches_fact
where _sys_transform_id = (select max(id) from _sys_transform_id where ts_end is not null and entity = 'dm_GLBatches_fact')
;