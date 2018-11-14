CREATE OR REPLACE VIEW out_vw_accountsegmentvalues AS
SELECT
	SegmentId::VARCHAR(512) as "a__accountsegment__accountsegmentfieldid",
	AccountSegmentValue::VARCHAR(512) as "a__accountsegment__accountsegmentvaluetext",
	Gooddata_attr(AccountId||'#'||SegmentId)::VARCHAR(512) as "cp__accountsegment__accountsegment",
	SegmentName::VARCHAR(512) as "l__accountsegment__accountsegmentfieldid__accountsegmentfieldname",
	AccountId::VARCHAR(512) as "r__accounts",
	TenantId::VARCHAR(128) as x__client_id
FROM stg_csv_AccountSegmentValue_merge;
